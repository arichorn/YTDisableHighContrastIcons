#import <UIKit/UIKit.h>
#import "../YouTubeHeader/YTCommonColorPalette.h"

@interface YTCollectionViewCell : UICollectionViewCell
@end

@interface YTSettingsCell : YTCollectionViewCell
@end

@interface YTSettingsSectionItem : NSObject
@property BOOL hasSwitch;
@property BOOL switchVisible;
@property BOOL on;
@property BOOL (^switchBlock)(YTSettingsCell *, BOOL);
@property int settingItemId;
- (instancetype)initWithTitle:(NSString *)title titleDescription:(NSString *)titleDescription;
@end

%hook YTSettingsViewController
- (void)setSectionItems:(NSMutableArray <YTSettingsSectionItem *>*)sectionItems forCategory:(NSInteger)category title:(NSString *)title titleDescription:(NSString *)titleDescription headerHidden:(BOOL)headerHidden {
	if (category == 1) {
		NSInteger appropriateIdx = [sectionItems indexOfObjectPassingTest:^BOOL(YTSettingsSectionItem *item, NSUInteger idx, BOOL *stop) {
			return item.settingItemId == 294;
		}];
		if (appropriateIdx != NSNotFound) {
		        YTSettingsSectionItem *ytDisableHighContrastIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Disable The High Contrast Icons" titleDescription:@"App restart is required."];
		        ytDisableHighContrastIcons.hasSwitch = YES;
                        ytDisableHighContrastIcons.switchVisible = YES;
			ytDisableHighContrastIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytDisableHighContrastIcons_enabled"];
			ytDisableHighContrastIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
				[[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytDisableHighContrastIcons_enabled"];
				return YES;
			};
			[sectionItems insertObject:ytDisableHighContrastIcons atIndex:appropriateIdx + 1];
		}
	}
	%orig;
}
%end

%hook YTSystemIcons
- (void)setHidden:(BOOL)hidden {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ytDisableHighContrastIcons_enabled"])
		hidden = YES;
	%orig;
}
%end
