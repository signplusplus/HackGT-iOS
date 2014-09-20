//
//  ViewController.m
//  Sign
//
//  Created by Andrew Thieck on 9/19/14.
//  Copyright (c) 2014 Andrew Thieck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    bool isRecording;
    CGRect viewFrame;
    CGRect typingViewFrame;
    UIView *contentView;
    UILabel *title;
    UILabel *inputTextLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[[Data defaultData] sendMessage:@"hello" toNumber:[NSNumber numberWithLong:19089677453]];
    
    CGRect callFrame;
    CGRect callShadowFrame;
    CGRect notesFrame;
    CGRect recordStopFrame;
    CGRect inputTextLabelFrame;
    CGRect lineFrame1;
    CGRect lineFrame2;
    CGRect lineFrame3;
    CGRect titleFrame;
    int nameFontSize;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        // 5 and 5s
        callFrame = CGRectMake(15, 176, 7 * self.view.frame.size.width/9 - 10, 40);
        callShadowFrame = CGRectMake(14, 180, 7 * self.view.frame.size.width/9 - 8, 40);
        notesFrame = CGRectMake(15, 7, 7*self.view.frame.size.width/9 - 10, 40);
        recordStopFrame = CGRectMake(20, 65, 7 * self.view.frame.size.width/9 - 20, 36);
        inputTextLabelFrame = CGRectMake(15, 116, 7*self.view.frame.size.width/9 - 10, 40);
        lineFrame1 = CGRectMake(10, 53, 7 * self.view.bounds.size.width / 9, 1);
        lineFrame2 = CGRectMake(10, 168, 7 * self.view.bounds.size.width / 9, 1);
        lineFrame3 = CGRectMake(10, 111, 7 * self.view.bounds.size.width / 9, 1);
        viewFrame = CGRectMake(self.view.frame.size.width / 12, 1.65 * self.view.frame.size.height / 3 - 30, 10 * self.view.frame.size.width/12, self.view.frame.size.height/3 + 40);
        typingViewFrame = CGRectMake(self.view.frame.size.width / 12, 0.7 * self.view.frame.size.height / 3 - 30, 10 * self.view.frame.size.width/12, self.view.frame.size.height/3 + 40);
        titleFrame = CGRectMake(self.view.frame.size.width/4.5 - 30, 40, 3.5* self.view.frame.size.width / 4.5, 60);
        nameFontSize = 12;
    } else {
        callFrame = CGRectMake(19, 276, 7 * self.view.frame.size.width/11 - 10, 40);
        callShadowFrame = CGRectMake(17, 280, 7 * self.view.frame.size.width/11 - 6, 40);
        notesFrame = CGRectMake(0, 23, 4 * self.view.frame.size.width/6, 40);
        recordStopFrame = CGRectMake(24, 110, 7 * self.view.frame.size.width/11 - 20, 36);
        inputTextLabelFrame = CGRectMake(0, 190, 4 * self.view.frame.size.width/6, 40);
        lineFrame1 = CGRectMake(12, 80, 7 * self.view.bounds.size.width / 9 - 110, 1);
        lineFrame2 = CGRectMake(12, 255, 7 * self.view.bounds.size.width / 9 - 110, 1);
        lineFrame3 = CGRectMake(12, 170, 7 * self.view.bounds.size.width / 9 - 110, 1);
        viewFrame = CGRectMake(self.view.frame.size.width / 6, 1.65 * self.view.frame.size.height / 3 + 0, 4 * self.view.frame.size.width/6, self.view.frame.size.height/3 + 0);
        typingViewFrame = CGRectMake(self.view.frame.size.width / 6, 1.65 * self.view.frame.size.height / 3 - 200, 4 * self.view.frame.size.width/6, self.view.frame.size.height/3 + 0);
        titleFrame = CGRectMake(self.view.frame.size.width/4.5 - 110, 40, 3.5* self.view.frame.size.width / 4.5 + 60, 120);
        nameFontSize = 16;
    }
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(-80, 0, self.view.frame.size.width + 160, 4*self.view.frame.size.height/5)];
    backgroundImage.image = [UIImage imageNamed:@"gt.png"];
    [self.view addSubview:backgroundImage];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    contentView = [[UIView alloc] initWithFrame:viewFrame];
    contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    contentView.layer.borderColor = [UIColor grayColor].CGColor;
    contentView.layer.borderWidth = 2.0f;
    contentView.layer.cornerRadius = 4;
    contentView.clipsToBounds = YES;
    [self.view addSubview:contentView];
    
    /*
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
    */
     
    notes = [[UITextView alloc] initWithFrame:notesFrame];
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
    
    inputTextLabel = [[UILabel alloc] initWithFrame:inputTextLabelFrame];
    inputTextLabel.textColor = [UIColor grayColor];
    inputTextLabel.font = [UIFont systemFontOfSize:20];
    inputTextLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    inputTextLabel.text = @"Live text preview";
    [inputTextLabel setTextAlignment:NSTextAlignmentCenter];
    [contentView addSubview:inputTextLabel];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:callShadowFrame];
    shadowView.backgroundColor = [UIColor lightGrayColor];
    shadowView.layer.cornerRadius = 6;
    shadowView.clipsToBounds = YES;
    [contentView addSubview:shadowView];
    
    UIButton *callButton = [[UIButton alloc] initWithFrame:callFrame];
    [callButton setTitle:@"send voice" forState:UIControlStateNormal];
    [callButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    [callButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setBackgroundColor: [UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    callButton.layer.cornerRadius = 6;
    callButton.clipsToBounds = YES;
    [contentView addSubview:callButton];
    
    recordStopButton = [[UIButton alloc] initWithFrame:recordStopFrame];
    [recordStopButton setTitle:@"begin recording" forState:UIControlStateNormal];
    [recordStopButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    [recordStopButton addTarget:self action:@selector(recordStartStop:) forControlEvents:UIControlEventTouchUpInside];
    [recordStopButton setBackgroundColor: [UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    recordStopButton.layer.cornerRadius = 6;
    recordStopButton.clipsToBounds = YES;
    [contentView addSubview:recordStopButton];
    
    title = [[UILabel alloc] initWithFrame:titleFrame];
    title.text = @"SIGN++";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    title.font = [UIFont fontWithName:@"Georgia-Bold" size:40];
    [self.view addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:lineFrame1];
    lineView.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:lineFrame3];
    lineView3.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView3];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:lineFrame2];
    lineView2.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView2];
    
    UILabel *names = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/5 + 4, 3.3 * self.view.frame.size.height/4, 3*self.view.frame.size.width/5 + 15, self.view.frame.size.height/5)];
    names.text = @"Madelayna Vaca • Payam Ghobadpour";
    names.textColor = [UIColor blackColor];
    names.font = [UIFont fontWithName:@"Helvetica" size:nameFontSize];
    names.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:names];
    
    UILabel *names2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/5, 3.3 * self.view.frame.size.height/4 + 19, 3*self.view.frame.size.width/5, self.view.frame.size.height/5)];
    names2.text = @"Kelley Sheffield • Andrew Thieck";
    names2.textColor = [UIColor blackColor];
    names2.font = [UIFont fontWithName:@"Helvetica" size:nameFontSize];
    names2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:names2];
    
}

- (void) recordStartStop: (id) sender {
    if (!isRecording) {
        isRecording = YES;
        [recordStopButton setTitle:@"stop recording" forState:UIControlStateNormal];
    } else {
        isRecording = NO;
        [recordStopButton setTitle:@"begin recording" forState:UIControlStateNormal];
    }
    
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
/*
- (void) segmentedControlChange: (UISegmentedControl *) segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        isSigner = YES;
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        isSigner = NO;
    }
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
