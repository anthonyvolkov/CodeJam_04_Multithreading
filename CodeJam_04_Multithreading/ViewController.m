//
//  ViewController.m
//  CodeJam_04_Multithreading
//
//  Created by anthony volkov on 5/31/18.
//  Copyright © 2018 anthony volkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int coordinateY;

- (void)calculationCoordinateY;

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
        [v removeFromSuperview];
    }
    [self createButton];
    
    NSURL *imageURL1 = [NSURL URLWithString:@"https://i.pinimg.com/originals/87/06/39/870639883348ac2df7c6bab980e16e5c.gif"];
    NSURL *imageURL2 = [NSURL URLWithString:@"https://i.pinimg.com/originals/e5/44/02/e54402c3b6f3a8f09b0339fa29c30553.jpg"];
    NSURL *imageURL3 = [NSURL URLWithString:@"https://image.freepik.com/free-icon/no-translate-detected_318-40184.jpg"];
    
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL1]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView1.image = image1;
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width - 110, 100)];
            label1.text = [NSString stringWithFormat:@"%@", imageURL1];
            
            [strongSelf calculationCoordinateY];
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(5, strongSelf.coordinateY, self.view.bounds.size.width - 10, 100)];
            view1.backgroundColor = [UIColor redColor];
            [view1 addSubview:imageView1];
            [view1 addSubview:label1];
            
            [strongSelf.view addSubview:view1];
            [view1 release];
            [imageView1 release];
            [label1 release];
        });
    });
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL2]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
            UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView2.image = image2;
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width - 110, 100)];
            label2.text = [NSString stringWithFormat:@"%@", imageURL2];
            
            [strongSelf calculationCoordinateY];
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(5, strongSelf.coordinateY, self.view.bounds.size.width - 10, 100)];
            view2.backgroundColor = [UIColor greenColor];
            [view2 addSubview:imageView2];
            [view2 addSubview:label2];
            
            [strongSelf.view addSubview:view2];
            [view2 release];
            [imageView2 release];
            [label2 release];
        });
    });
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL3]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self)strongSelf = weakSelf;
            UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView3.image = image3;
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width - 110, 100)];
            label3.text = [NSString stringWithFormat:@"%@", imageURL3];
            
            [strongSelf calculationCoordinateY];
            UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(5, strongSelf.coordinateY, self.view.bounds.size.width - 10, 100)];
            view3.backgroundColor = [UIColor yellowColor];
            [view3 addSubview:imageView3];
            [view3 addSubview:label3];
            
            [strongSelf.view addSubview:view3];
            [view3 release];
            [imageView3 release];
            [label3 release];
        });
    });
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(5, 370, self.view.bounds.size.width - 10, 100)];
    view4.backgroundColor = [UIColor blackColor];
    
    
    dispatch_group_async(group, queue, ^{
        UIImage *image5 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL1]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView5.image = image5;
            [view4 addSubview:imageView5];
            [imageView5 release];
        });
            
    });
    
    dispatch_group_async(group, queue, ^{
        UIImage *image6 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL2]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(107, 0, 100, 100)];
            imageView6.image = image6;
            [view4 addSubview:imageView6];
            [imageView6 release];
        });
        
    });

    dispatch_group_async(group, queue, ^{
        UIImage *image7 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL3]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(214, 0, 100, 100)];
            imageView7.image =  image7;
            [view4 addSubview:imageView7];
            [imageView7 release];
        });
    
        
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


- (void)calculationCoordinateY {
    NSLog(@"%d", self.coordinateY);
    
    if (self.coordinateY == 0) {
        self.coordinateY = self.coordinateY + 20;
    }else{
        self.coordinateY = self.coordinateY + 100;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
