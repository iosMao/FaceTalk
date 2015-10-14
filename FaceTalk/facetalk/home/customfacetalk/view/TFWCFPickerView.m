//
//  TFWPickerView.m
//  test
//
//  Created by wen on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWCFPickerView.h"

@interface TFWCFPickerView ()

@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,assign) int index;

@end

@implementation TFWCFPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        [self buildView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in _pickView.subviews) {
        if (view.subviews.count == 0) {
            view.hidden = YES;
        }
    }
}

-(void)buildView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"tfw_cf_numberpickerback"];
    [self addSubview:imageView];
    
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, -48, 0, 0)];
    _pickView.showsSelectionIndicator = YES;
    [_pickView.layer setBounds:CGRectMake(0, 0, 327 - 50, 80)];
    [_pickView.layer setContentsRect:self.bounds];
    _pickView.dataSource = self;
    _pickView.delegate = self;
    [self addSubview:_pickView];
    
    for (int i = 0; i < 4; i++) {
        [_pickView selectRow:5000 + i inComponent:i animated:NO];
    }
    
//    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animationPicker:) userInfo:nil repeats:YES];
}

//-(void)animationPicker:(NSTimer *)timer
//{
//    switch (_index % 4) {
//        case 0:
//                [_pickView selectRow:5000 + _index / 4 + 0 inComponent:0 animated:YES];
//            break;
//            
//        case 1:
//                [_pickView selectRow:5000 + _index / 4 + 1 inComponent:1 animated:YES];
//            break;
//            
//        case 2:
//                [_pickView selectRow:5000 + _index / 4 + 2 inComponent:2 animated:YES];
//            break;
//            
//        case 3:
//                [_pickView selectRow:5000 + _index / 4 + 3 inComponent:3 animated:YES];
//            break;
//            
//        default:
//            break;
//    }
//    
//    _index++;
//    if (_index > 40) {
//        [timer invalidate];
//    }
//    
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10000;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",row % 4 + 1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"sdsdsds%@",[self getCurrentSelected]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FTWPOSTPICKERVIEWSELECTEDNUMBER" object:nil ];
    
}

-(NSArray *)getCurrentSelected
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++) {
        [array addObject:[NSString stringWithFormat:@"%ld",[_pickView selectedRowInComponent:i] % 4 + 1]];
    }
    
    return array;
}

@end
