import Flutter
import UIKit
import AssetsLibrary
import Photos
import MobileCoreServices
import ZLPhotoBrowser


public class SwiftImagesPicker: NSObject  {
    @objc public var selectImagePickerBlock: ( ([UIImage], [PHAsset], Bool) -> Void )?
    @objc public var selectVideoPickerBlock: ( ([UIImage], [PHAsset], Bool) -> Void )?
    @objc public var cancelBlock: ( () -> Void )?
    
    @objc(selectImagePicker:selectImagePickerBlock:cancelBlock:)
    public func selectImagePicker(count: Int, selectImagePickerBlock:@escaping  (_ images:[UIImage],_ assets: [PHAsset],_ isOriginal:Bool) ->(),cancelBlock:@escaping ()->() )  {
        let supportGif = false;
        let language="Language.Chinese";
        // let pickType = args!["pickType"] as? String;
        let pickType="PickType.image";
      
        let vc = UIApplication.shared.delegate!.window!!.rootViewController!;
        let ac = ZLPhotoPreviewSheet();
        let config = ZLPhotoConfiguration.default();
        self.setLanguage(configuration: config, language: language);
        self.setConfig(configuration: config, pickType: pickType);
        config.maxSelectCount = count;
        config.allowSelectGif = supportGif;
       
        
        ac.selectImageBlock = { (images, assets, isOriginal) in
            //
            selectImagePickerBlock(images,assets,isOriginal);
            
        }
        ac.cancelBlock = {
            // result([]);
            cancelBlock();
        }
        ac.showPhotoLibrary(sender: vc);
    }
    
    @objc(selectVideoPicker:selectVideoPickerBlock:cancelBlock:)
    public func selectVideoPicker(count: Int, selectVideoPickerBlock:@escaping  (_ images:[UIImage],_ assets: [PHAsset],_ isOriginal:Bool) ->(),cancelBlock:@escaping ()->() )  {
        let supportGif = false;
        let language="Language.Chinese";
        let pickType="PickType.video";
        
        let vc = UIApplication.shared.delegate!.window!!.rootViewController!;
        let ac = ZLPhotoPreviewSheet();
        let config = ZLPhotoConfiguration.default();
        self.setLanguage(configuration: config, language: language);
        self.setConfig(configuration: config, pickType: pickType);
        config.maxSelectCount = count;
        config.allowSelectGif = supportGif;
        // self.setThemeColor(configuration: config, colors: theme);
        
        ac.selectImageBlock = { (images, assets, isOriginal) in
            //
            selectVideoPickerBlock(images,assets,isOriginal);
            
        }
        ac.cancelBlock = {
            // result([]);
            cancelBlock();
        }
        ac.showPhotoLibrary(sender: vc);
    }
    
    
    
    private func setConfig(configuration: ZLPhotoConfiguration, pickType: String?) {
        //    configuration.style = .externalAlbumList;
        configuration.allowTakePhotoInLibrary = false;
        configuration.allowMixSelect = true;
        configuration.allowEditImage = false;
        configuration.allowEditVideo = false;
        configuration.saveNewImageAfterEdit = false;
        if pickType=="PickType.video" {
            configuration.allowSelectImage = false;
            configuration.allowSelectVideo = true;
        } else if pickType=="PickType.all" {
            configuration.allowSelectImage = true;
            configuration.allowSelectVideo = true;
        } else {
            configuration.allowSelectImage = true;
            configuration.allowSelectVideo = false;
        }
        configuration.allowSlideSelect = false;
    }
    
    private func setLanguage(configuration: ZLPhotoConfiguration, language: String) {
        switch language {
        case "Language.Chinese":
            configuration.languageType = .chineseSimplified;
            break;
        case "Language.ChineseTraditional":
            configuration.languageType = .chineseTraditional;
            break;
        case "Language.English":
            configuration.languageType = .english;
            break;
        case "Language.Japanese":
            configuration.languageType = .japanese;
            break;
        case "Language.French":
            configuration.languageType = .french;
            break;
        case "Language.Korean":
            configuration.languageType = .korean;
            break;
        case "Language.German":
            configuration.languageType = .german;
            break;
        case "Language.Vietnamese":
            configuration.languageType = .vietnamese;
            break;
        default:
            configuration.languageType = .system;
        }
    }
    
    private func setThemeColor(configuration: ZLPhotoConfiguration, colors: NSDictionary?) {
        let theme = ZLPhotoThemeColorDeploy();
        configuration.themeColorDeploy = theme;
    }
}
