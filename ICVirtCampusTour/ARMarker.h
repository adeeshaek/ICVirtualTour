
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
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

- (id)initWithImage:(NSString *)image
           andTitle:(NSString*)title;

- (void)expandInfoView;

@end

@protocol detailViewControllerDelegate <NSObject>

-(void)setCellDataWithName:(NSString*)name andImageName:(NSString*)imageName andText:(NSString*)text;

@end