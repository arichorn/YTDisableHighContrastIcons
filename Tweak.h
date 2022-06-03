@interface YTRightNavigationButtons
@property(readonly, nonatomic) YTQTMButton *creationButton;
@end

@interface YTQTMButton : UIButton
@end

@interface YTRightNavigationButtons
@property(readonly, nonatomic) YTQTMButton *MDXButton;
@property(readonly, nonatomic) YTQTMButton *searchButton;
@property(readonly, nonatomic) YTQTMButton *notificationButton;
@end

@interface YTUserDefaults : NSObject
- (long long)appThemeSetting;
@end
