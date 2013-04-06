
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface ARView : UIView  <CLLocationManagerDelegate> {
}

@property (nonatomic, retain) NSArray *placesOfInterest;
/**
 *	@brief	used to figure out when labels overlap. is a hashtable of arrays for speed
 */
@property (nonatomic, retain) NSHashTable *placesDict;

//test code
@property NSInteger maxX;
@property NSInteger minX;

- (void)start;
- (void)stop;
@end
