//
//  ViewController.m
//  Lab7_1
//
//  Created by Admin on 25.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *canvas;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic, strong) UIColor *lineColor;
@property (weak, nonatomic) IBOutlet UIButton *blackColorButton;
@property (nonatomic) CGFloat lineWidth;
@property (weak, nonatomic) IBOutlet UIButton *redColorButton;
@property (weak, nonatomic) IBOutlet UIButton *blueColorButton;
@property (weak, nonatomic) IBOutlet UIButton *greenColorButton;
@property (weak, nonatomic) IBOutlet UILabel *setColor;
@property (weak, nonatomic) IBOutlet UILabel *setWidth;
@property (weak, nonatomic) IBOutlet UIPickerView *lineWidthVariants;
@property (nonatomic, strong) NSArray *brushSizes;
@property (weak, nonatomic) IBOutlet UISwitch *brushType;
@property (weak, nonatomic) IBOutlet UIButton *brushTypeRound;
@end

@implementation ViewController

/*- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUi];
    [self initData];
}

- (void) initUi
{
    self.canvas = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200)];
    self.canvas.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.canvas];
    
    self.lineWidthVariants.delegate = self;
    self.lineWidthVariants.dataSource = self;
    
    _lineColor = [UIColor blackColor];
}

- (void) initData
{
    self.brushSizes = @[@"3",@"5",@"7",@"10",@"15"];
    self.lineWidth = 3.f;
}

- (IBAction)changeColorForBlack:(id)sender {
    _lineColor = [UIColor blackColor];
}

- (IBAction)changeColorForRed:(id)sender {
    _lineColor = [UIColor redColor];
}

- (IBAction)changeColorForBlue:(id)sender {
    _lineColor = [UIColor blueColor];
}
- (IBAction)changeColorForGreen:(id)sender {
    _lineColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width,
                                 self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    if([_lineColor isEqual:[UIColor redColor]])
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 0.0f, 0.0f, 1.0f);
    if([_lineColor isEqual:[UIColor blueColor]])
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0f, 0.0f, 1.0f, 1.0f);
    if([_lineColor isEqual:[UIColor greenColor]]	)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0f, 1.0f, 0.0f, 1.0f);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.lineWidth);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}
#pragma mark - UIPickerView Delegate,DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.brushSizes.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.brushSizes[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.lineWidth = [self.brushSizes[row] floatValue];
}




@end
