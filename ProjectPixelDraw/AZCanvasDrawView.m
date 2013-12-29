//
//  AZCanvasDrawView.m
//  ProjectPixelDraw
//
//  Created by Alex Alexandrov on 19.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZCanvasDrawView.h"

@implementation AZCanvasDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.colorDraw = [UIColor redColor];
        self.pointDraw = CGPointMake(-50, -50);
        self.sizeDraw = CGSizeMake(25, 25);
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef contextCanvasView = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextCanvasView, self.colorDraw.CGColor);
    
    CGContextFillRect(contextCanvasView, CGRectMake(self.pointDraw.x,
                                          self.pointDraw.y,
                                          self.sizeDraw.width, self.sizeDraw.height));
    CGContextFillPath(contextCanvasView);
    
}


@end
