//
//  ViewWithImageAndURlLabel.m
//  CodeJam_04_Multithreading
//
//  Created by anthony volkov on 6/1/18.
//  Copyright © 2018 anthony volkov. All rights reserved.
//

#import "ViewWithImageAndURLLabel.h"

@interface ViewWithImageAndURLLabel ()


@end

@implementation ViewWithImageAndURLLabel

+ (instancetype)viewWithCoordinateY:(CGFloat)coordinateY andImage:(UIImage *)image andURLLabel:(NSURL *)imageURL{
    ViewWithImageAndURLLabel *view = [[[ViewWithImageAndURLLabel alloc] initWithFrame:CGRectMake(5, coordinateY, [UIScreen mainScreen].bounds.size.width - 10, 100)] autorelease];
    view.backgroundColor = [self randomColor];
    
    [view addSubview:[self addImageViewWithImage:image]];
    [view addSubview:[self addLabelWithText:[NSString stringWithFormat:@"%@", imageURL]]];
    
    return view;
}

+ (UIColor *)randomColor {
    CGFloat red = (CGFloat)(arc4random() % 256 / 255.f);
    CGFloat green = (CGFloat)(arc4random() % 256 / 255.f);
    CGFloat blue = (CGFloat)(arc4random() % 256 / 255.f);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

+ (UIImageView *)addImageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
    imageView.image = image;
    return imageView;
}

+ (UILabel *)addLabelWithText:(NSString *)text {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.width - 10, 100)] autorelease];
    label.text = text;
    return label;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
