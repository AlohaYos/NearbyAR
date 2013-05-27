//
//  DetailViewController.m
//  Nearby
//
//  Created by Yos Hashimoto.
//  Copyright Newton Japan Inc. 2009. All rights reserved.
//

#import "DetailViewController.h"
#import "Article.h"
#import "AppData.h"
#import	"Annotation.h"

@implementation DetailViewController

@synthesize appData, anArticle, currentAnnotation, webViewController;

#pragma mark -
#pragma mark viewController delegate

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"";
	currentAnnotation = nil;
	mapView.delegate = self;
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(rotateTimerJob) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.title = anArticle.title;
	[tableView reloadData];

	MKCoordinateRegion zoom = mapView.region;
	zoom.span.latitudeDelta = 0.005;
	zoom.span.longitudeDelta = 0.005;
	[mapView setRegion:zoom animated:NO];

	CLLocationCoordinate2D point;
	point.latitude  = [anArticle.lat doubleValue];
	point.longitude = [anArticle.lon doubleValue];
	[mapView setCenterCoordinate:point animated:NO];	
	
	if(currentAnnotation) {
		[mapView removeAnnotation:currentAnnotation];
		[currentAnnotation release];
		currentAnnotation = nil;
	}
	currentAnnotation = [[Annotation alloc] initWithCoordinate:point];
	currentAnnotation.title = anArticle.title;
	currentAnnotation.subtitle = [NSString stringWithFormat:@"　現在地から %@ m", anArticle.distance];
	[mapView addAnnotation:currentAnnotation];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Object lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	
	[anArticle release];
	[tableView release];
    [super dealloc];
}


#pragma mark -
#pragma mark TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ReuseCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch(indexPath.row)
	{
		case 0:
			cell.textLabel.text = [NSString stringWithFormat:@"緯度　%@",  anArticle.lat];
			break;
		case 1:
			cell.textLabel.text = [NSString stringWithFormat:@"経度　%@",  anArticle.lon];
			break;
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tblView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionName = nil;
	
	switch(section)
	{
		case 0:
			sectionName = @"情報";
			break;
	}
	
	return sectionName;
}

#pragma mark -
#pragma mark MapView

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	
	// annotationの中身（クラス名）を調べる
	Class cl = [annotation class];
	NSString *desc = [cl description];

	// MKUserLocation or Annotation
	if ([desc compare:@"Annotation"] == NSOrderedSame) {
		// Annotationクラスだった場合には、目的地の情報を示すためにコールアウトを設定する
		MKPinAnnotationView *annotateView=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentAnnotation"] autorelease];
		annotateView.pinColor = MKPinAnnotationColorRed;
		annotateView.animatesDrop=YES;
		annotateView.canShowCallout = YES;
		UIButton *myDetailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		annotateView.rightCalloutAccessoryView = myDetailButton;
		return annotateView;
	}
	else {
		// ユーザーロケーション用のアノテーションは必要ないので設定しない
		// システムデフォルトのロケーション表示（青い波紋のようなアニメーション）で表現される
		return nil;
	}
}

// コールアウトのディスクロージャーボタンが押された
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

	if(!webViewController) {
		webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	}
	webViewController.anArticle = anArticle;
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}


-(void)rotateTimerJob {
	mapView.transform = CGAffineTransformMakeRotation(-M_PI * appData.heading / 180.0f);
}



@end
