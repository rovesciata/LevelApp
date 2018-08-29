//
//  LicenceViewController.swift
//  LevelApp
//
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit

class LicenceViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var licenceTextView: UITextView!

    
    var url = NSURL(string: "http://icons8.com/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseString = "このアプリのアイコンはこちらのサイトの素材を使用しています。\n\nicons8.com(http://icons8.com/)\n\nflaticon(http://www.flaticon.com/)\n\n<div>Icons made by <a href=(https://www.flaticon.com/authors/egor-rumyantsev) title=Egor Rumyantsev>Egor Rumyantsev</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=http://www.freepik.com title=Freepik>Freepik</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=(https://www.flaticon.com/authors/yannick) title=Yannick>Yannick</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=(https://www.flaticon.com/authors/icomoon) title=Icomoon>Icomoon</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=http://www.freepik.com title=Freepik>Freepik</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=(https://www.flaticon.com/authors/yannick) title=Yannick>Yannick</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>\n\n<div>Icons made by <a href=http://www.freepik.com title=Freepik>Freepik</a> from <a href=https://www.flaticon.com/ title=Flaticon>www.flaticon.com</a> is licensed by <a href=http://creativecommons.org/licenses/by/3.0/ title=Creative Commons BY 3.0 target=_blank>CC 3.0 BY</a></div>"
        
        let attributedString = NSMutableAttributedString(string: baseString)
        
        attributedString.addAttribute(.link,
                                      value: "http://icons8.com/",
                                      range: NSString(string: baseString).range(of: "http://icons8.com/"))
        
        attributedString.addAttribute(.link,
                                      value: "http://www.flaticon.com/",
                                      range: NSString(string: baseString).range(of: "http://www.flaticon.com/"))
        
        attributedString.addAttribute(.link,
                                      value: "https://www.flaticon.com/authors/egor-rumyantsev",
                                      range: NSString(string: baseString).range(of: "https://www.flaticon.com/authors/egor-rumyantsev"))
        
        attributedString.addAttribute(.link,
                                      value: "https://www.flaticon.com/authors/yannick",
                                      range: NSString(string: baseString).range(of: "https://www.flaticon.com/authors/yannick"))
        
        attributedString.addAttribute(.link,
                                      value: "https://www.flaticon.com/authors/icomoon",
                                      range: NSString(string: baseString).range(of: "https://www.flaticon.com/authors/icomoon"))
        
        
        
        licenceTextView.attributedText = attributedString
        licenceTextView.isSelectable = true
        licenceTextView.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL)
        
        return false
    }
    
    
}
