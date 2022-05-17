#import <UIKit/UIKit.h>

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
			YTSettingsSectionItem *HighContrastIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"High Contrast Icons" titleDescription:@"Allows you to Enable/Disable the High Contrast Icons for Light/Dark Mode"];
			HighContrastIcons.hasSwitch = YES;
			HighContrastIcons.switchVisible = YES;
			HighContrastIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"high_contrast_icons_enabled"];
			HighContrastIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
				[[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"high_contrast_icons_enabled"];
				return YES;
			};
			[sectionItems insertObject:HighContrastIcons atIndex:appropriateIdx + 1];
		}
	}
	%orig;
}
%end

%hook YTSystemIcons
- (void)setHidden:(BOOL)hidden {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"high_contrast_icons_enabled"])
		hidden = YES;
	%orig;
}
%end
