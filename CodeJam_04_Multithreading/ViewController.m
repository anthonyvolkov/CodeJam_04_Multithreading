//
//  ViewController.m
//  CodeJam_04_Multithreading
//
//  Created by anthony volkov on 5/31/18.
//  Copyright © 2018 anthony volkov. All rights reserved.
//

#import "ViewController.h"
#import "ViewWithImageAndURLLabel.h"

@interface ViewController ()

@property (nonatomic, assign)CGFloat coordinateY;

- (CGFloat)calculationCoordinateY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
    [self createButton];
    
}

- (void)createButton {
    UIButton *loadData = [UIButton buttonWithType:UIButtonTypeSystem];
    loadData.frame = CGRectMake(50,
                                self.view.bounds.size.height - 70,
                                self.view.bounds.size.width - 100,
                                50);
    [loadData setBackgroundColor:[UIColor blueColor]];
    [loadData setTitle:@"load data" forState:UIControlStateNormal];
    [loadData setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
    [loadData addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadData];
}

- (void)loadData {
    NSLog(@"loadData button clicked");
    
    self.coordinateY = 0;
    
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        if ([v isKindOfClass:[ViewWithImageAndURLLabel class]]) {
            [v removeFromSuperview];
        }
    }
    
    NSURL *imageURL1 = [NSURL URLWithString:@"https://i.pinimg.com/originals/87/06/39/870639883348ac2df7c6bab980e16e5c.gif"];
    NSURL *imageURL2 = [NSURL URLWithString:@"https://i.pinimg.com/originals/e5/44/02/e54402c3b6f3a8f09b0339fa29c30553.jpg"];
    NSURL *imageURL3 = [NSURL URLWithString:@"https://image.freepik.com/free-icon/no-translate-detected_318-40184.jpg"];
    
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL1]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
            
            ViewWithImageAndURLLabel *view1 = [ViewWithImageAndURLLabel viewWithCoordinateY:strongSelf.calculationCoordinateY andImage:image1 andURLLabel:imageURL1];
            [strongSelf.view addSubview:view1];
            
        });
    });
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL2]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
           
            ViewWithImageAndURLLabel *view2 = [ViewWithImageAndURLLabel viewWithCoordinateY:strongSelf.calculationCoordinateY andImage:image2 andURLLabel:imageURL2];
            [strongSelf.view addSubview:view2];
            
        });
    });
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL3]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
           
            ViewWithImageAndURLLabel *view3 = [ViewWithImageAndURLLabel viewWithCoordinateY:strongSelf.calculationCoordinateY andImage:image3 andURLLabel:imageURL3];
            [strongSelf.view addSubview:view3];
            
        });
    });
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    ViewWithImageAndURLLabel *view4 = [[ViewWithImageAndURLLabel alloc] initWithFrame:CGRectMake(5, 370, self.view.bounds.size.width - 10, 100)];
    view4.backgroundColor = [UIColor blackColor];
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        UIImage *image5 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL1]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView5.image = image5;
            [view4 addSubview:imageView5];
            [imageView5 release];
            
        });
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        UIImage *image6 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL2]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(107, 0, 100, 100)];
            imageView6.image = image6;
            [view4 addSubview:imageView6];
            [imageView6 release];
        });
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        UIImage *image7 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL3]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(214, 0, 100, 100)];
            imageView7.image =  image7;
            [view4 addSubview:imageView7];
            [imageView7 release];
        });
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
    
            [strongSelf.view addSubview:view4];
            [view4 release];
        });
    });
    
    dispatch_release(group);
}


- (CGFloat)calculationCoordinateY {
    if (self.coordinateY == 0) {
        self.coordinateY = self.coordinateY + 20;
    }else{
        self.coordinateY = self.coordinateY + 100;
    }
    return self.coordinateY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
