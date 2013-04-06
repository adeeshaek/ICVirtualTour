//
//  VirtTourViewController.m
//  ICVirtCampusTour
//
//  Created by jason debottis on 3/27/13.
//  Copyright (c) 2013 IC. All rights reserved.
//

#import "VirtTourViewController.h"

//Augmented Reality headers
#import "PlaceOfInterest.h"
#import "ARView.h"
#import "ARMarker.h"

//Map View headers
#import "Annotation.h"
#import "MapOverlay.h"
#import "MapOverlayView.h"

#define METERS_PER_MILE 1609.344

@interface VirtTourViewController ()

@end

@implementation VirtTourViewController

-(void)showDetailedViewWithName:(NSString*)name
{
    NSLog(@"WORKING!");
}

-(void)httpError
{
    NSLog(@"Error with internet connection...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ARView *arView = (ARView *)self.view;
    
    //get building names and locations from database
    _myDBWrapper = [DBWrapper alloc];
    
    NSArray* buildings = [_myDBWrapper getAllBuildingsWithCallback:^
    {
        [self httpError];
    }];
    
    /*
     checking contents of dictionary
    for (int i=0; i<buildings.count; i++)
    {
        NSLog(@"%@", [buildings objectAtIndex:i]);
    }
     */
    
    /*
     old code to hard-code the locations
    _buildingNames = [[NSMutableArray alloc]init];
    [_buildingNames addObject:@"Williams"];
    [_buildingNames addObject:@"Health SCiences"];
    [_buildingNames addObject:@"Hill"];
    [_buildingNames addObject:@"DestinyUSA"];
    
    CLLocationCoordinate2D poiCoords[] ={{42.422694, -76.495196},
                                         {42.420075,-76.49806},
                                         {42.420566,-76.497073},
                                         {43.072855,-76.171569}};
    
    int numPois = sizeof(poiCoords) / sizeof(CLLocationCoordinate2D);
    

	NSMutableArray *placesOfInterest = [NSMutableArray arrayWithCapacity:numPois];
	for (int i = 0; i < numPois; i++) {
        ARMarker *marker = [[ARMarker alloc]initWithImage:@"Pointer.PNG" andTitle:[NSString stringWithFormat:@"%@",[_buildingNames objectAtIndex:i]]];
		PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:marker at:[[CLLocation alloc] initWithLatitude:poiCoords[i].latitude longitude:poiCoords[i].longitude]];
		[placesOfInterest insertObject:poi atIndex:i];
	}
	[arView setPlacesOfInterest:placesOfInterest];
    */
    
    NSMutableArray* placesOfInterest = [NSMutableArray arrayWithCapacity:buildings.count];
    for (int i=0; i<buildings.count; i++)
    {
        NSDictionary* building = [buildings objectAtIndex:i];
        
        ARMarker* marker = [[ARMarker alloc] initWithImage:@"Pointer.PNG" andTitle:[building objectForKey:@"name"]];
        
        marker.parent = self;
        
        double latitude = [[building objectForKey:@"x"] doubleValue];
        double longitude = [[building objectForKey:@"y"] doubleValue];
        
        PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:marker at:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude]];
		[placesOfInterest insertObject:poi atIndex:i];
    }
    
    [arView setPlacesOfInterest:placesOfInterest];
    
    _theMapView = [[MKMapView alloc]init];
    _theMapView.frame = [[UIScreen mainScreen]bounds];
    _theMapView.delegate = self;
    _theMapView.mapType = MKMapTypeStandard;
    _theMapView.showsUserLocation = YES;
    
    //add the campus map overlay
    _mapOverlay = [[MapOverlay alloc]init];
    [_theMapView addOverlay:_mapOverlay];
    _userLocation = _theMapView.userLocation;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_userLocation.location.coordinate, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    [_theMapView setRegion:region animated:YES];

    // Listen for changes in device orientation
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleOrientaionChanges)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
    
    _mapOverlay = (MapOverlay*)overlay;
    _mapOverlayView = [[MapOverlayView alloc]initWithOverlay:_mapOverlay];
    
    return _mapOverlayView;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //Annotation *theAnnotation = [[Annotation alloc]initWithCoordinates:_userLocation.coordinate title:@"ME" subTitle:@"I am here"];
    
    //To add more than one location pin
    //NSArray *myPins = [[NSArray alloc]initWithObjects:theAnnotation, nil];
    //[_theMapView addAnnotation:theAnnotation];
    _theMapView.centerCoordinate = userLocation.location.coordinate;
    [_theMapView setZoomEnabled:YES];
    
}
- (void)handleOrientaionChanges{
    UIDevice *theDevice = [UIDevice currentDevice];
    if (theDevice.orientation == UIDeviceOrientationFaceUp) {
        NSLog(@"Face Up");
        [self.view addSubview:_theMapView];
        _ARViewDisplayed = NO;
    }else {
        [_theMapView removeFromSuperview];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	ARView *arView = (ARView *)self.view;
    _ARViewDisplayed = YES;
	[arView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
