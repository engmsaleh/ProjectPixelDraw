//
//  AZViewController.m
//  ProjectPixelDraw
//
//  Created by Alex Alexandrov on 19.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZViewController.h"
#import "AZToolsDrawView.h"
#import "AZCanvasDrawView.h"

@interface AZViewController ()

@property (strong, nonatomic) AZToolsDrawView *toolsView;
@property (strong, nonatomic) AZCanvasDrawView *canvasView;
@property (strong, nonatomic) NSMutableArray *heapColorViews;
@property (strong, nonatomic) NSMutableArray *heapSizeViews;

@end

@implementation AZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect rectToolsView = CGRectMake(0, 0, 210, CGRectGetHeight(self.view.frame));
    CGRect rectCanvasView = CGRectMake(210, 0, CGRectGetWidth(self.view.frame) - 210, CGRectGetHeight(self.view.frame));
    
    self.toolsView = [[AZToolsDrawView alloc] initWithFrame:CGRectInset(rectToolsView, 10, 55)];
    
    self.toolsView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    
    self.toolsView.backgroundColor = [UIColor whiteColor];
    
    self.toolsView.layer.borderWidth = 2.0;
    self.toolsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.toolsView.layer.shadowOffset = CGSizeZero;
    self.toolsView.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.toolsView];
    
    self.canvasView = [[AZCanvasDrawView alloc] initWithFrame:CGRectInset(rectCanvasView, 10, 55)];
    
    self.canvasView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                         UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    self.canvasView.backgroundColor = [UIColor whiteColor];
    self.canvasView.layer.borderWidth = 2.0;
    self.canvasView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.canvasView.layer.shadowOffset = CGSizeZero;
    self.canvasView.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.canvasView];
    
    CGPoint pointColorFrame = CGPointMake(25, 50);
    
    self.heapColorViews = [self createColorViews: [self listOfColors]
                                       pointView: pointColorFrame
                                    andParenView: self.toolsView];
    
    self.heapSizeViews = [self createSizeViews:CGRectMake(pointColorFrame.x,
                                                          pointColorFrame.y + 170,
                                                          self.canvasView.sizeDraw.width,
                                                          self.canvasView.sizeDraw.height) andParenView:self.toolsView];
    
    }

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.toolsView];
    UIView *anyTouchView = [self.toolsView hitTest:pointTouchView withEvent:event];
    
    for(UIView *anyView in self.heapColorViews){
        
        if([anyView isEqual:anyTouchView]){
            
            self.canvasView.colorDraw = anyTouchView.backgroundColor;
            self.toolsView.colorFrame = anyTouchView.backgroundColor;
            self.toolsView.rectFrame = CGRectMake(CGRectGetMinX(anyTouchView.frame) - 5,
                                                  CGRectGetMinY(anyTouchView.frame) - 5,
                                                  40, 40);
        }
    }
    
    
    for(UIView *anyView in self.heapSizeViews){
        
        if([anyView isEqual:anyTouchView]){
            
            anyView.layer.borderColor = [UIColor redColor].CGColor;
            self.canvasView.sizeDraw = anyView.frame.size;
        }
        else{
            anyView.layer.borderColor = [UIColor grayColor].CGColor;
        }
    }
    
    
    CGPoint pointTouchCanvas = [anyTouch locationInView:self.canvasView];
    
    self.canvasView.pointDraw = CGPointMake(pointTouchCanvas.x - self.canvasView.sizeDraw.width / 2,
                                            pointTouchCanvas.y - self.canvasView.sizeDraw.height / 2);
    
    [self.canvasView setNeedsDisplayInRect:CGRectMake(self.canvasView.pointDraw.x,
                                                      self.canvasView.pointDraw.y,
                                                      self.canvasView.sizeDraw.width,
                                                      self.canvasView.sizeDraw.height)];
    
    [self.toolsView setNeedsDisplay];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.canvasView];
    
    self.canvasView.pointDraw = CGPointMake(pointTouchView.x - self.canvasView.sizeDraw.width / 2,
                                            pointTouchView.y - self.canvasView.sizeDraw.height / 2);
    
    [self.canvasView setNeedsDisplayInRect:CGRectMake(self.canvasView.pointDraw.x,
                                                      self.canvasView.pointDraw.y,
                                                      self.canvasView.sizeDraw.width,
                                                      self.canvasView.sizeDraw.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - colors methods

- (NSArray *) listOfColors{
    
    NSArray * arrayColor = [[NSArray alloc] initWithObjects:[UIColor redColor],
                                                            [UIColor blueColor],
                                                            [UIColor greenColor],
                                                            [UIColor yellowColor],
                                                            [UIColor grayColor],
                                                            [UIColor blackColor],
                                                            [UIColor whiteColor],
                                                            [UIColor cyanColor],
                                                            [UIColor magentaColor],
                                                            [UIColor orangeColor],
                                                            [UIColor purpleColor],
                                                            [UIColor brownColor],nil];

    return arrayColor;
}

- (NSMutableArray *) createColorViews: (NSArray *) listColors pointView: (CGPoint) pointView andParenView: (UIView *) parentView{
    
    NSInteger countColor = 0;
    NSMutableArray * heapColorViews = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 3; i++){
        
        for(int j = 0; j < 4; j++){
            
            UIView *anyColorView = [[UIView alloc] initWithFrame:CGRectMake(pointView.x, pointView.y, 30, 30)];
            
            anyColorView.backgroundColor = [listColors objectAtIndex:countColor];
            anyColorView.layer.borderWidth = 1.0;
            anyColorView.layer.borderColor = [UIColor grayColor].CGColor;
            
            [parentView addSubview:anyColorView];
            [heapColorViews addObject:anyColorView];
            
            pointView.x +=40;
            countColor++;
        }
        pointView.x = 25;
        pointView.y +=40;
    }
    
    return heapColorViews;
}

- (NSMutableArray *) createSizeViews: (CGRect) rectView andParenView: (UIView *) parentView{
    
    NSMutableArray * heapSizeViews = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 3; i++){
        
        UIView *anyViews = [[UIView alloc] initWithFrame:rectView];
        
        anyViews.backgroundColor = [UIColor yellowColor];
        anyViews.alpha = 0.4f;
        
        if(i == 0){
            anyViews.layer.borderColor = [UIColor redColor].CGColor;
            anyViews.layer.borderWidth = 3.0;
        }
        else{
            anyViews.layer.borderColor = [UIColor grayColor].CGColor;
            anyViews.layer.borderWidth = 2.0;
        }

        [parentView addSubview:anyViews];
        [heapSizeViews addObject:anyViews];
        
        rectView.origin.x += rectView.size.width + 20;
        rectView.size.width += 25;
        rectView.size.height += 25;
    }
    return heapSizeViews;
}

#pragma mark - Orientation

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    [self.toolsView setNeedsDisplay];
    [self.canvasView setNeedsDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
