

#import "ARMarker.h"
//#import "ARCoordinate.h"

#define BOX_WIDTH 180
#define BOX_HEIGHT 50

@implementation ARMarker
 
- (id)initWithImage:(NSString *)image
       andTitle:(NSString*)title{
    
    _name = title;
    
	CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);	
	if (self = [super initWithFrame:theFrame]) {
                
        //Create the title lable
		_titleLabel	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH, 20.0)];        
		_titleLabel.backgroundColor = [UIColor colorWithWhite:.3 alpha:.8];
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.textAlignment = NSTextAlignmentLeft;
		_titleLabel.text = title;
        
        //Create the expand button
        _expandViewButton = [[UIButton alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x + 150, _titleLabel.frame.origin.y, 40, 50)];
        [_expandViewButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [_expandViewButton addTarget:self action:@selector(launchInfoView) forControlEvents:UIControlEventTouchUpInside];
		                
        //Add the marker views
        [self addSubview:_titleLabel];
		[self addSubview:_expandViewButton];
		[self setBackgroundColor:[UIColor colorWithRed:155 green:155 blue:155 alpha:0.5]];
	}
	

    return self;
}

-(void)launchInfoView
{
    [_parent showDetailedViewWithRowId:_rowId];
}


@end
