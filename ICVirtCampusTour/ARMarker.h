
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "VirtTourViewController.h"
#import <UIKit/UIKit.h>

@class ARCoordinate;
@class ARDetailedViewController;

@protocol detailViewController;

@interface ARMarker : UIView {

}
@property (nonatomic, strong) UIWebView *infoView;
@property (nonatomic, strong) UIButton *expandViewButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) BOOL expanded;
@property (nonatomic, strong) VirtTourViewController* parent;
@property (nonatomic, strong) NSString* name;

- (id)initWithImage:(NSString *)image
           andTitle:(NSString*)title;

- (void)expandInfoView;

@end

@protocol detailViewControllerDelegate <NSObject>

-(void)setCellDataWithName:(NSString*)name andImageName:(NSString*)imageName andText:(NSString*)text;

@end