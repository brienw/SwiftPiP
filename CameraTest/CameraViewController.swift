import UIKit
import AVFoundation


class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    let session                     : AVCaptureSession = AVCaptureSession()
    var previewLayer                : AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var cameraSubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the camera
        let device = getFrontCamera()
        var error   : NSError? = nil
        
        let input   : AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
        
        if input != nil {
            session.addInput(input)
        }else{
            println(error)
        }
        
        // SKIPPING OUTPUT FOR NOW
        var output : AVCaptureOutput
        
        previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as! AVCaptureVideoPreviewLayer
        previewLayer.frame = cameraSubView.bounds
        previewLayer.setAffineTransform( CGAffineTransformTranslate(CGAffineTransformMakeScale(0.33, 0.33), -375, -480) )
        previewLayer.position=CGPointMake(CGRectGetMidX(cameraSubView.bounds), CGRectGetMidY(cameraSubView.bounds));
        
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        cameraSubView.layer.addSublayer(previewLayer)
        
        session.startRunning()
    }
    
    func getFrontCamera() -> AVCaptureDevice{
        var result : AVCaptureDevice!
        var devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices{
            if (device.position == AVCaptureDevicePosition.Front) {
                result = device as! AVCaptureDevice
            }
        }
        return result
    }
    
}
