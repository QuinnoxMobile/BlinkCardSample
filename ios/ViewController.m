//
//  ViewController.m
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 19/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Microblink/Microblink.h>
#import "NativeiOSBridgePOC/AppDelegate.h"
#import "CardManager.h"


@interface ViewController ()<MBBlinkCardOverlayViewControllerDelegate>
@property (nonatomic, nonnull) MBBlinkCardRecognizer *blinkCardRecognizer;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *validThruLabel;
@property (nonatomic,assign)NSString * cardNumberValue;
@property (nonatomic,assign)NSDate * validThru;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIButton *saveCardButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveCardConstraint;
@property (weak, nonatomic) IBOutlet UIButton *scanCardButton;
@property (weak, nonatomic) IBOutlet UILabel *cvvLabel;
@property (nonatomic,strong)NSMutableArray * cardArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//Time-Limited License Key from MicroBlink Card
  [[MBMicroblinkSDK sharedInstance] setLicenseKey:@("sRwAAAESY29tLmltYWQuYmxpbmtjYXJkv9DemiNhnaipmjNDWwP9C0wf3MJCHJrPr/EvKIyADz7z0AXU6/9OvVttmZhYwMfOi01q/335Nk3wOIpQmFr6yA9pnTzVO7qkWFBvRpmvO3hDu9KeeUzT1f0tPlAIiyRZaJK0EtYhe4R5oa/pFt77rlxj4IaQ8TdJV383mpX4J1ttz4LZUcJPlPk=")];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  });
    // Do any additional setup after loading the view.
  if(self.cardNumberValue == nil){
    [_cardView setHidden:YES];
    [_saveCardButton setHidden:YES];
  }
}

//Action of the ScanCard Button Clicked
- (IBAction)didTapScan:(id)sender {
  self.blinkCardRecognizer = [[MBBlinkCardRecognizer alloc] init];
  self.blinkCardRecognizer.extractCvv = YES;
  self.blinkCardRecognizer.returnFullDocumentImage = YES;
  MBRecognizerCollection *recognizerCollection = [[MBRecognizerCollection alloc] initWithRecognizers:@[self.blinkCardRecognizer]];
  MBBlinkCardOverlaySettings *overlaySettings = [[MBBlinkCardOverlaySettings alloc] init];
  MBBlinkCardOverlayViewController *blinkCardOveralyViewController = [[MBBlinkCardOverlayViewController alloc] initWithSettings:overlaySettings recognizerCollection:recognizerCollection delegate:self];
  UIViewController<MBRecognizerRunnerViewController>* recognizerRunnerViewController = [MBViewControllerFactory recognizerRunnerViewControllerWithOverlayViewController:blinkCardOveralyViewController];
  [self presentViewController:recognizerRunnerViewController animated:YES completion:nil];
}

//Action for SaveCard Button clicked
- (IBAction)saveCard:(id)sender {
  AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  [appDelegate goToReactNative];
  CardManager * data = [CardManager allocWithZone:nil];
  [data tellJS:self.cardArray];
}

//Function where camera will be opened and card will be scanned
//Get all the info of the Credit or Debit card
- (void)blinkCardOverlayViewControllerDidFinishScanning:(nonnull MBBlinkCardOverlayViewController *)blinkCardOverlayViewController state:(MBRecognizerResultState)state {
  [blinkCardOverlayViewController.recognizerRunnerViewController pauseScanning];
  NSString *title;
  NSString * cardValue;
  NSString * validThru;
  NSString * cvvValue;
  if (self.blinkCardRecognizer.result.resultState == MBRecognizerResultStateValid) {
    title = @"Payment card";
    UIImage *fullDocumentImage = self.blinkCardRecognizer.result.fullDocumentFrontImage.image;
    NSLog(@"Got payment card image with width: %f, height: %f", fullDocumentImage.size.width, fullDocumentImage.size.height);
    cardValue = self.blinkCardRecognizer.result.cardNumber;
    validThru = self.blinkCardRecognizer.result.validThru.originalDateString;
    self.cardNumberValue = cardValue;
    cvvValue = self.blinkCardRecognizer.result.cvv;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    if(cardValue!=nil){
      [self.cardView setHidden:NO];
      [self.scanCardButton setHidden:YES];
      [self.saveCardButton setHidden:NO];
      self.cardNumberLabel.text = cardValue;
      self.cardImageView.image = self.blinkCardRecognizer.result.fullDocumentFrontImage.image;
      self.validThruLabel.text = validThru;
      self.cvvLabel.text = self.blinkCardRecognizer.result.cvv;
      self.saveCardConstraint.constant = 100;
      self.cardArray = [[NSMutableArray alloc]init];
       self.cardArray= [NSMutableArray arrayWithObjects:cardValue,validThru,cvvValue, nil];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"Successfully Scanned the Card" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
     [blinkCardOverlayViewController dismissViewControllerAnimated:YES completion:nil];
      
    }];
   UIAlertAction * cancelAction =  [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
   }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [blinkCardOverlayViewController presentViewController:alertController animated:YES completion:nil];
  });
}

- (void)blinkCardOverlayViewControllerDidTapClose:(nonnull MBBlinkCardOverlayViewController *)blinkCardOverlayViewController {
  [blinkCardOverlayViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
