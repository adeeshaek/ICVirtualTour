//
//  VirtTourViewController.h
//  ICVirtCampusTour
//
//  Created by jason debottis on 3/27/13.
//  Copyright (c) 2013 IC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>
#import "DBWrapper.h"


@class MapOverlay;
@class MapOverlayView;

@protocol detailViewControllerDelegate;

@interface VirtTourViewController : UIViewController<MKMapViewDelegate>

-(void)httpError;
-(void)showDetailedViewWithRowId:(NSInteger)rowId;

@property (nonatomic, strong) MapOverlay *mapOverlay;
@property (nonatomic, strong) MapOverlayView *mapOverlayView;
@property (nonatomic, strong) MKMapView *theMapView;
@property (nonatomic, strong) MKUserLocation *userLocation;
@property (nonatomic, strong) CMMotionManager *manager;

@property (nonatomic, strong) DBWrapper* myDBWrapper;
@property (nonatomic, strong) NSArray* buildings;

@property (nonatomic, strong) NSMutableArray *buildingNames;
@property (nonatomic) BOOL ARViewDisplayed;
@end

@protocol detailViewControllerDelegate <NSObject>

-(void)setCellDataWithName:(NSString *)name andImageName:(NSString *)imageName andText:(NSString *)text;

@end
