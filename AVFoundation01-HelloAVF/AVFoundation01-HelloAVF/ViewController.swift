//
//  ViewController.swift
//  AVFoundation01-HelloAVF
//
//  Created by Erickson on 16/1/4.
//  Copyright © 2016年 erickson. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UITableViewController {

    let speechManager = SpeechManager()
    var speechStrings = [String]()

    override func viewDidLoad() {
        speechManager.synthesizer.delegate = self
        speechManager.beginConversation()
        
    }
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return speechStrings.count
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = indexPath.row % 2 == 0 ? "myCell" : "AVCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) as! BubbleCell
        cell.messageLabel.text = speechStrings[indexPath.row]
        return cell
    }

}



extension ViewController:AVSpeechSynthesizerDelegate{
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        speechStrings.append(utterance.speechString)
        tableView.reloadData()
        
        let index = NSIndexPath(forRow: speechStrings.count-1, inSection: 0)
        
        tableView.scrollToRowAtIndexPath(index, atScrollPosition: .Bottom, animated: true)
    }
}





class SpeechManager {
    
    let synthesizer : AVSpeechSynthesizer
    private let voices: [AVSpeechSynthesisVoice]
    private let speechString: [String]
    init(){
        synthesizer = AVSpeechSynthesizer()
        voices = [AVSpeechSynthesisVoice(language: "zh-TW")!,
        AVSpeechSynthesisVoice(language: "zh-HK")!]
        /*
        
        */
        speechString = ["河水往哪里流啊","大河向东流啊","天上有多少颗星星阿","天上的星星参北斗阿","你给我滚出去","说走咱就走阿","你有病吧","你有我有全都有阿","你再唱一句试试","路见不平一生吼阿","你信不信我奏你","该出手时就出手阿","我让你退学","风风火火闯九洲阿"]
    }
    
    
    
    func beginConversation(){
        for i in 0..<speechString.count {
            let utterance = AVSpeechUtterance(string: speechString[i])
            utterance.voice = voices[i%2]
            utterance.rate = 0.5
            utterance.pitchMultiplier = 0.8
            utterance.postUtteranceDelay = 0.2
            synthesizer.speakUtterance(utterance)
        }
    }

    
    

}