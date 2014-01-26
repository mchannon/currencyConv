//
//  currencyConvViewController.h
//  currencyConv
//
//  Created by Lrrr on 1/25/14.
//  Copyright (c) 2014 currencyConv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currencyConvViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UILabel *mlabel;
    
    NSMutableArray *arrayNo;
    
    IBOutlet UIPickerView *pickerView;
    
}


@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *usd;
@property (weak, nonatomic) IBOutlet UILabel *eur;
@property (weak, nonatomic) IBOutlet UILabel *jpy;
@property (weak, nonatomic) IBOutlet UILabel *cny;
@property (weak, nonatomic) IBOutlet UILabel *cdn;
@property (weak, nonatomic) IBOutlet UILabel *chf;
@property (weak, nonatomic) IBOutlet UIImageView *usdImage;
@property (weak, nonatomic) IBOutlet UIImageView *eurImage;
@property (weak, nonatomic) IBOutlet UIImageView *jpyImage;
@property (weak, nonatomic) IBOutlet UIImageView *cnyImage;
@property (weak, nonatomic) IBOutlet UIImageView *cdnImage;
@property (weak, nonatomic) IBOutlet UIImageView *chfImage;
@property (weak, nonatomic) IBOutlet UIPickerView *fromPV;

@end
