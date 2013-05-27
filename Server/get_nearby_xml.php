<?php

	// ---　入力パラメーター　---
	$lat = $_GET['lat'];	// 北緯
	$lon = $_GET['lon'];	// 東経
	$nearby = $_GET['nearby'];	// 何メートル以内の情報をピックアップするか
	$count = $_GET['count'];	// ピックアップする情報の上限数

	// MySQLへ接続
	include('./server_config.php');
	$db = mysql_connect($sql_server, $sql_user, $sql_pw);
	if($db==False){
		echo "ホスト、ユーザーID、パスワードのいずれかが間違っています";
		exit;
	}
	mysql_query("SET NAMES utf8", $db);  // 文字化け対策

	// WordPressのメタ情報からLat_Longのキーを持つものを抽出
	$result = mysql_select_db($sql_db);
	$sql = "SELECT * FROM wp_nearby_postmeta WHERE meta_key='Lat_Long'";
	$result = mysql_query($sql);

	// 位置情報を持つエントリーについて繰り返し
	$entry_list = "";
	while ($item = mysql_fetch_array($result))
		{
		$LatLong = $item["meta_value"];
		list($db_lat, $db_lon) = split(',', $LatLong);
		
		// iPhoneの現在位置に近いものをピックアップする
		$meter = calc_distance($db_lat, $db_lon, $lat, $lon);
		if($meter <= $nearby)	// 指定の距離以内の場合
			{
			$post_id = $item["post_id"];	// 投稿記事ID
//			echo "nearby=entry" . $post_id . " [ " . $db_lat . " , " . $db_lon . " (" . $meter. "m) ] <br />";
			// 投稿記事のIDをメモする
			if($entry_list =="")
					$entry_list = $post_id;
				else
					$entry_list = $entry_list . "," . $post_id;

			// エントリーIDと付属情報を連想配列で持つ
			$tmpStr = "e" . $post_id;
			$meterList[$tmpStr] = $meter;
			$latList[$tmpStr]=$db_lat;
			$lonList[$tmpStr]=$db_lon;
			}
		}

	// 抽出された記事IDを元に、一覧を作成する
	$result = mysql_select_db($sql_db);
	$sql = "SELECT *FROM wp_nearby_posts WHERE ID IN($entry_list);";
	$result = mysql_query($sql);

	$ret  = "<articles>\n";

	// 位置情報を持つエントリーについて繰り返し
	$entry_count = 0;
	while ($item = mysql_fetch_array($result))
		{
		$article_id = $item["ID"];
		$entry_title = $item["post_title"];
//		$entry_title = mb_convert_encoding($entry_title, "UTF8");
		$tmpStr = "e" . $article_id;
		$tmpDistance = $meterList[$tmpStr];
		$tmpDistance = round($tmpDistance / 10);
		$tmpDistance = $tmpDistance * 10;
		$tmpLat = $latList[$tmpStr];
		$tmpLon = $lonList[$tmpStr];

		$ret .= "<article>";
		$ret .= "<articleID>" . $article_id . "</articleID><lat>" . $tmpLat . "</lat><lon>" . $tmpLon . "</lon><title>" . $entry_title . "</title><distance>" . $tmpDistance . "</distance>";
		$ret .= "</article>\n";

		$entry_count = $entry_count + 1;			
		if($entry_count >= $count) break;
		}
	$ret .= "</articles>\n";

	echo $ret;

exit;


// --- 緯度・経度から２点間の距離（メートル）を求める　---
function calc_distance($a_lat, $a_lon, $b_lat, $b_lon)
{
	$sirad = $a_lat*M_PI/180;		//始点　緯度 ラジアンに変換
	$skrad = $a_lon*M_PI/180;		// 始点　経度　ラジアンに変換
 	$syirad = $b_lat*M_PI/180;		// 終点　緯度　ラジアンに変換
 	$sykrad = $b_lon*M_PI/180;		// 終点　経度　ラジアンに変換
 
	$aveirad = ($sirad + $syirad)/2; 	//２点間の平均緯度を計算
 	$deffirad = $sirad - $syirad;		//２点間の緯度差を計算
 	$deffkrad = $skrad - $sykrad;		//２点間の経度差を計算
 	$temp = 1 - 0.006674*(sin($aveirad)*sin($aveirad));
	$dmrad = 6334834 / sqrt($temp*$temp*$temp);	//子午線曲率半径を計算
 	$dvrad = 6377397 / sqrt($temp);		//卯酉線曲率半径を取得
 
	$t1 = $dmrad * $deffirad;		//ヒュベニの距離計算式
	$t2 = $dvrad*Cos($aveirad)*$deffkrad;
	$d = sqrt($t1*$t1 + $t2*$t2);
 
	return $d;
 
// echo "2点間の距離は";
// echo $d;
// echo "mです。";

}


 ?>
 
 