//
//  MainViewController.m
//  gesture
//
//  Created by Taeho Ko on 7/8/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic) int selectedImageIndex;
@property (nonatomic) int topZlayerIndex;
@property (weak, nonatomic) UIImageView *justAddedImage;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // View & property setup
    self.navigationController.navigationBar.hidden = YES;
    self.topZlayerIndex = 999;
    
    // Add images
    UIImageView *imageView01 = [[UIImageView alloc] initWithFrame:CGRectMake(8,514,48,48)];
    UIImageView *imageView02 = [[UIImageView alloc] initWithFrame:CGRectMake(72,514,48,48)];
    UIImageView *imageView03 = [[UIImageView alloc] initWithFrame:CGRectMake(136,514,48,48)];
    UIImageView *imageView04 = [[UIImageView alloc] initWithFrame:CGRectMake(200,514,48,48)];
    UIImageView *imageView05 = [[UIImageView alloc] initWithFrame:CGRectMake(264,514,48,48)];
    
    imageView01.image = [UIImage imageNamed:(@"character_01")];
    imageView02.image = [UIImage imageNamed:(@"character_02")];
    imageView03.image = [UIImage imageNamed:(@"character_03")];
    imageView04.image = [UIImage imageNamed:(@"character_04")];
    imageView05.image = [UIImage imageNamed:(@"character_05")];
    
    imageView01.userInteractionEnabled = YES;
    imageView02.userInteractionEnabled = YES;
    imageView03.userInteractionEnabled = YES;
    imageView04.userInteractionEnabled = YES;
    imageView05.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView01];
    [self.view addSubview:imageView02];
    [self.view addSubview:imageView03];
    [self.view addSubview:imageView04];
    [self.view addSubview:imageView05];
    
    UIPanGestureRecognizer *panGestureRecognizer01 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanImage01:)];
    UIPanGestureRecognizer *panGestureRecognizer02 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanImage02:)];
    UIPanGestureRecognizer *panGestureRecognizer03 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanImage03:)];
    UIPanGestureRecognizer *panGestureRecognizer04 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanImage04:)];
    UIPanGestureRecognizer *panGestureRecognizer05 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanImage05:)];
    
    [imageView01 addGestureRecognizer:panGestureRecognizer01];
    [imageView02 addGestureRecognizer:panGestureRecognizer02];
    [imageView03 addGestureRecognizer:panGestureRecognizer03];
    [imageView04 addGestureRecognizer:panGestureRecognizer04];
    [imageView05 addGestureRecognizer:panGestureRecognizer05];
    
}

- (void)onPanImage01:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.selectedImageIndex = 1;
    [self addImageView:panGestureRecognizer];
}

- (void)onPanImage02:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.selectedImageIndex = 2;
    [self addImageView:panGestureRecognizer];
}

- (void)onPanImage03:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.selectedImageIndex = 3;
    [self addImageView:panGestureRecognizer];
}

- (void)onPanImage04:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.selectedImageIndex = 4;
    [self addImageView:panGestureRecognizer];
}

- (void)onPanImage05:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.selectedImageIndex = 5;
    [self addImageView:panGestureRecognizer];
}

- (void)addImageView:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint point = [panGestureRecognizer locationInView:self.view];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {

        self.justAddedImage = [self createNewImageView];
        self.justAddedImage.center = CGPointMake(point.x, point.y);
        
        [UIView animateWithDuration:0.1 animations:^{
            self.justAddedImage.transform = CGAffineTransformMakeScale(2.4, 2.4);
        }];
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint newCenter = self.justAddedImage.center;
        newCenter.x += [panGestureRecognizer translationInView:self.view].x;
        newCenter.y += [panGestureRecognizer translationInView:self.view].y;
        self.justAddedImage.center = newCenter;
        [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.1 animations:^{
            self.justAddedImage.transform = CGAffineTransformMakeScale(2, 2);
        }];
        
        self.justAddedImage.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *instancePanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanInstance:)];
        UIPinchGestureRecognizer *instancePinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinchInstance:)];
        UIRotationGestureRecognizer *instanceRotateGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onRotateInstance:)];
        UITapGestureRecognizer *instanceDoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTapInstance:)];
        UILongPressGestureRecognizer *instanceLongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressInstance:)];
        
        instancePinchGestureRecognizer.delegate = self;
        instanceRotateGestureRecognizer.delegate = self;
        instanceDoubleTapGestureRecognizer.delegate = self;
        instanceLongPressGestureRecognizer.delegate = self;
        
        instanceDoubleTapGestureRecognizer.numberOfTapsRequired = 2;
        
        [self.justAddedImage addGestureRecognizer:instancePanGestureRecognizer];
        [self.justAddedImage addGestureRecognizer:instancePinchGestureRecognizer];
        [self.justAddedImage addGestureRecognizer:instanceRotateGestureRecognizer];
        [self.justAddedImage addGestureRecognizer:instanceDoubleTapGestureRecognizer];
        [self.justAddedImage addGestureRecognizer:instanceLongPressGestureRecognizer];

    }

}

- (UIImageView *)createNewImageView {
    UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,48,48)];
    
    if (self.selectedImageIndex == 1) {
       newImage.image = [UIImage imageNamed:(@"character_01")];
    } else if (self.selectedImageIndex == 2) {
        newImage.image = [UIImage imageNamed:(@"character_02")];
    } else if (self.selectedImageIndex == 3) {
        newImage.image = [UIImage imageNamed:(@"character_03")];
    } else if (self.selectedImageIndex == 4) {
        newImage.image = [UIImage imageNamed:(@"character_04")];
    } else if (self.selectedImageIndex == 5) {
        newImage.image = [UIImage imageNamed:(@"character_05")];
    }
    
    [self.view addSubview:newImage];
    return newImage;
}

- (void)onPanInstance:(UIPanGestureRecognizer *)panGestureRecognizer {

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        panGestureRecognizer.view.layer.zPosition = self.topZlayerIndex;
        self.topZlayerIndex += 1;
        
        [UIView animateWithDuration:0.1 animations:^{
            panGestureRecognizer.view.transform = CGAffineTransformScale(panGestureRecognizer.view.transform, 1.2, 1.2);
        }];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint newCenter = panGestureRecognizer.view.center;
        newCenter.x += [panGestureRecognizer translationInView:self.view].x;
        newCenter.y += [panGestureRecognizer translationInView:self.view].y;
        panGestureRecognizer.view.center = newCenter;
        [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.1 animations:^{
            panGestureRecognizer.view.transform = CGAffineTransformScale(panGestureRecognizer.view.transform, 1.0/1.2, 1.0/1.2);
        }];
        
    }
    
}

- (void)onPinchInstance:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
}

- (void)onRotateInstance:(UIRotationGestureRecognizer *)rotateGestureRecogenizer {
    rotateGestureRecogenizer.view.transform = CGAffineTransformRotate(rotateGestureRecogenizer.view.transform, rotateGestureRecogenizer.rotation);
    rotateGestureRecogenizer.rotation = 0;
}

- (void)onDoubleTapInstance:(UITapGestureRecognizer *)doubleTapGestureRecogenizer {
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         doubleTapGestureRecogenizer.view.transform = CGAffineTransformScale(doubleTapGestureRecogenizer.view.transform, 1.2, 1.2);
//                         doubleTapGestureRecogenizer.view.alpha = 0;
//                     } completion:^(BOOL finished) {
//                         [doubleTapGestureRecogenizer.view removeFromSuperview];
//                     }];
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         doubleTapGestureRecogenizer.view.center = CGPointMake(doubleTapGestureRecogenizer.view.center.x - 10, doubleTapGestureRecogenizer.view.center.y);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.6
                                          animations:^{
                                              doubleTapGestureRecogenizer.view.center = CGPointMake(doubleTapGestureRecogenizer.view.center.x + 420, doubleTapGestureRecogenizer.view.center.y);
                                          } completion:^(BOOL finished) {
                                              [doubleTapGestureRecogenizer.view removeFromSuperview];
                                          }];
                     }];
    

}

- (void)onLongPressInstance:(UILongPressGestureRecognizer *)longPressGestureRecogenizer {
    if (longPressGestureRecogenizer.state == UIGestureRecognizerStateBegan) {
        longPressGestureRecogenizer.view.transform = CGAffineTransformScale(longPressGestureRecogenizer.view.transform, -1, 1);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
