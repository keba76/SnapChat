//
//  AVCameraVCDelegate.h
//  SnapChat
//
//  Created by Ievgen Keba on 11/13/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef AVCameraVCDelegate_h
#define AVCameraVCDelegate_h

@protocol AVCameraVCDelegate <NSObject>

-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
-(void)videoRecordingComplete:(NSURL*)videoURL;
-(void)videoRecordingFailed;

@end


#endif /* AVCameraVCDelegate_h */
