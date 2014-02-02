//
//  currencyConvViewController.m
//  currencyConv
//
//  Created by Lrrr on 1/25/14.
//  Copyright (c) 2014 currencyConv. All rights reserved.
//

#import "currencyConvViewController.h"

#define nwf(x) [NSNumber numberWithFloat:x]

@interface currencyConvViewController ()


@end

NSArray *rates;

@implementation currencyConvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    rates = [ NSArray arrayWithObjects:nwf(1),nwf(0.73),nwf(102.31),nwf(6.05),nwf(1.11),nwf(0.90), nil];
    
    arrayNo = [[NSMutableArray alloc] init];
    [ arrayNo addObject:@"USD"];
    [ arrayNo addObject:@"EUR"];
    [ arrayNo addObject:@"JPY"];
    [ arrayNo addObject:@"CNY"];
    [ arrayNo addObject:@"CDN"];
    [ arrayNo addObject:@"CHF"];
    [pickerView selectRow:1 inComponent:0 animated:NO];
    mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];

    _usdImage.image  = [UIImage imageNamed:@"usd.jpg"];
    _eurImage.image  = [UIImage imageNamed:@"eur.jpeg"];
    _jpyImage.image  = [UIImage imageNamed:@"jpy.jpeg"];
    _cnyImage.image  = [UIImage imageNamed:@"cny.jpeg"];
    _cdnImage.image  = [UIImage imageNamed:@"cdn.jpeg"];
    _chfImage.image  = [UIImage imageNamed:@"chf.jpeg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Convert:(id)sender {
    

    float oldRate = [[ rates objectAtIndex:[ pickerView selectedRowInComponent:0] ] floatValue];
    
    if ( [ _amount.text floatValue ] != 0 )
    {
        [_usd setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:0] floatValue] )]];
        [_eur setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:1] floatValue] )]];
        [_jpy setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:2] floatValue] )]];
        [_cny setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:3] floatValue] )]];
        [_cdn setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:4] floatValue] )]];
        [_chf setText:[NSString stringWithFormat:@"%.2f", ( [ _amount.text floatValue ] / oldRate * [ [rates objectAtIndex:5] floatValue] )]];
    }
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    
    for (id textField in self.view.subviews) {
        
        if ([textField isKindOfClass:[UITextField class]] && [textField isFirstResponder]) {
            [textField resignFirstResponder];
        }
    }
}

- (IBAction)USDwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/USD" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)EURwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/EUR" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)JPYwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/JPY" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)CNYwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/CNY" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)CDNwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/C$" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)CHFwiki:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://en.wikipedia.org/wiki/CHF" ];
    
    [[UIApplication sharedApplication] openURL:url];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    mlabel.text= [arrayNo objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayNo count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayNo objectAtIndex:row];
}

- (IBAction)LoadRates:(id)sender {
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error)
            NSLog( @"error");
        else
            [ self ParseData: data ];
    }];
}

- (void)ParseData:(NSData *)data
{
    NSError *error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    NSArray *m = [[ json objectForKey:@"list"] objectForKey:@"resources"];
    
    rates = [NSArray arrayWithObjects:
             [[[ m[84] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             [[[ m[63] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             [[[ m[93] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             [[[ m[62] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             [[[ m[24] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             [[[ m[94] objectForKey:@"resource"] objectForKey:@"fields" ] objectForKey:@"price" ],
             nil];
}

@end