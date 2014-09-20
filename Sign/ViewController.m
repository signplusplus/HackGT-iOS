//
//  ViewController.m
//  Sign
//
//  Created by Andrew Thieck on 9/19/14.
//  Copyright (c) 2014 Andrew Thieck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    bool isSigner;
    CGRect viewFrame;
    CGRect typingViewFrame;
    UIView *contentView;
    UILabel *title;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isSigner = YES;
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(-80, 0, self.view.frame.size.width + 160, 4*self.view.frame.size.height/5)];
    backgroundImage.image = [UIImage imageNamed:@"gt.png"];
    [self.view addSubview:backgroundImage];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    viewFrame = CGRectMake(self.view.frame.size.width / 12, 1.65 * self.view.frame.size.height / 3, 10 * self.view.frame.size.width/12, self.view.frame.size.height/3);
    typingViewFrame = CGRectMake(self.view.frame.size.width / 12, 0.7 * self.view.frame.size.height / 3, 10 * self.view.frame.size.width/12, self.view.frame.size.height/3);
    
    contentView = [[UIView alloc] initWithFrame:viewFrame];
    contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    contentView.layer.borderColor = [UIColor grayColor].CGColor;
    contentView.layer.borderWidth = 2.0f;
    contentView.layer.cornerRadius = 4;
    contentView.clipsToBounds = YES;
    [self.view addSubview:contentView];
    
    NSArray *segmentObjects = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"sign"], [NSString stringWithFormat:@"talk"], nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentObjects];
    segmentedControl.frame = CGRectMake(20, 10, 7 * self.view.frame.size.width/9 - 24, 30);
    //segmentedControl.frame = CGRectMake(self.view.frame.size.width/9, 1.7 * self.view.frame.size.height/3, 7 * self.view.frame.size.width/9, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    UIFont *font = [UIFont boldSystemFontOfSize:15.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    [contentView addSubview:segmentedControl];
    
    notes = [[UITextView alloc] initWithFrame:CGRectMake(15, 65, 7*self.view.frame.size.width/9 - 10, 40)];
    notes.delegate = self;
    notes.textColor = [UIColor lightGrayColor];
    [notes setReturnKeyType:UIReturnKeyDone];
    notes.font = [UIFont systemFontOfSize:20];
    notes.autocorrectionType = UITextAutocorrectionTypeYes;
    notes.editable = YES;
    notes.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    notes.text = @"Call this number...";
    notes.keyboardType = UIKeyboardTypePhonePad;
    [notes setTextAlignment:NSTextAlignmentCenter];
    [contentView addSubview:notes];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(14, 134, 7 * self.view.frame.size.width/9 - 8, 40)];
    shadowView.backgroundColor = [UIColor lightGrayColor];
    shadowView.layer.cornerRadius = 6;
    shadowView.clipsToBounds = YES;
    [contentView addSubview:shadowView];
    
    UIButton *callButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 130, 7 * self.view.frame.size.width/9 - 10, 40)];
    [callButton setTitle:@"call" forState:UIControlStateNormal];
    [callButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    [callButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setBackgroundColor: [UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    callButton.layer.cornerRadius = 6;
    callButton.clipsToBounds = YES;
    [contentView addSubview:callButton];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, self.view.frame.size.width-80, 60)];
    title.text = @"SIGN++";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    title.font = [UIFont fontWithName:@"Helvetica" size:40];
    [self.view addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 57, 7 * self.view.bounds.size.width / 9, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 111, 7 * self.view.bounds.size.width / 9, 1)];
    lineView2.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView2];
    
    UILabel *names = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/5 + 4, 3.3 * self.view.frame.size.height/4, 3*self.view.frame.size.width/5 + 15, self.view.frame.size.height/5)];
    names.text = @"Madelayna Vaca • Payam Ghobadpour";
    names.textColor = [UIColor blackColor];
    names.font = [UIFont fontWithName:@"Helvetica" size:12];
    names.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:names];
    
    UILabel *names2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/5, 3.3 * self.view.frame.size.height/4 + 19, 3*self.view.frame.size.width/5, self.view.frame.size.height/5)];
    names2.text = @"Kelley Sheffield • Andrew Thieck";
    names2.textColor = [UIColor blackColor];
    names2.font = [UIFont fontWithName:@"Helvetica" size:12];
    names2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:names2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveOrientationEvent:)
                                                 name:TLMMyoDidReceiveOrientationEventNotification
                                               object:nil];
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    //notes.frame = CGRectMake(notes.frame.origin.x, notes.frame.origin.y - self.view.frame.size.height/3, notes.frame.size.width, notes.frame.size.height);
    NSLog(@"called");
        [UIView animateWithDuration:.26
                         animations:^{
                             contentView.frame = typingViewFrame;
                         }
                         completion:^(BOOL finished) {
                             notes.text = @"";
                             notes.textColor = [UIColor blackColor];
                         }];
}


- (void) call:(id) sender {
    
}

- (void) segmentedControlChange: (UISegmentedControl *) segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        isSigner = YES;
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        isSigner = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceivePoseChange:(NSNotification*)notification {
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    /*
     Poses
    TLMPoseTypeFist
    TLMPoseTypeWaveIn
    TLMPoseTypeWaveOut
    TLMPoseTypeFingersSpread
    TLMPoseTypeThumbToPinky      
    TLMPoseTypeUnknown
     */
    
    //TODO: do something with the pose object.
}

- (void)didReceiveOrientationEvent:(NSNotification*)notification {
    TLMOrientationEvent *orientation = notification.userInfo[kTLMKeyOrientationEvent];
    
    //TODO: do something with the orientation object.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[touches anyObject] locationInView:contentView];

    if (!CGRectContainsPoint(notes.bounds, locationPoint) && [notes isFirstResponder]) {
        [notes resignFirstResponder];

        if(notes.text.length == 0) {
            notes.textColor = [UIColor lightGrayColor];
            notes.text = @"Call this number...";
        }
        
        [UIView animateWithDuration:.26
                         animations:^{
                             contentView.frame = viewFrame;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
}

@end
