//
//  MainMenu.swift
//  run
//
//  Created by Олеся Скидан on 07.05.2024.
//

import SpriteKit

class MainMenu: SKScene {
    
    //MARK: - Properties
    
    var containerNode: SKSpriteNode!
    
    //MARK: - Sistem
    
    override func didMove(to view: SKView) {
        setupBG()
        setupGrounds()
        setupNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        
        if node.name == "play" {
            let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            view!.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.3))
            
        } else if node.name == "highscore" {
            setupPanel()
            
        } else if node.name == "setting" {
            setupSetting()
            
        } else if node.name == "container" {
            containerNode.removeFromParent()
            
        } else if node.name == "music" {
            let node = node as! SKSpriteNode
            SKTAudio.musicEnable = !SKTAudio.musicEnable
            node.texture = SKTexture(imageNamed: SKTAudio.musicEnable ? "musicOn" : "musicOff")
        
        } else if node.name == "effect" {
            let node = node as! SKSpriteNode
            effectEnabled = !effectEnabled
            node.texture = SKTexture(imageNamed: effectEnabled ? "effectOn" : "effectOff")
        } else if node.name == "saveResult" {
            saveResultsFunction()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
}

//MARK: - Configurations

extension MainMenu {
    
    func setupBG() {
        let bgNode = SKSpriteNode(imageNamed: "background")
        bgNode.zPosition = -1.0
        bgNode.anchorPoint = .zero
        bgNode.position = .zero
        addChild(bgNode)
    }
    
    func setupGrounds() {
        for i in 0...2 {
            let groundNode = SKSpriteNode(imageNamed: "ground")
            groundNode.name = "ground"
            groundNode.anchorPoint = .zero
            groundNode.zPosition = 1.0
            groundNode.position = CGPoint(x: -CGFloat(i)*groundNode.frame.width, y: 0.0)
            addChild(groundNode)
        }
    }
    
    func moveGrounds() {
        enumerateChildNodes(withName: "ground") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= 8.0
            
            if node.position.x < -self.frame.width {
                node.position.x += node.frame.width*2.0
            }
        }
    }
    
    func setupNodes() {
        let scale: CGFloat = 0.90  // Новый масштаб для всех кнопок

        // Настройка кнопки 'Play'
        let play = SKSpriteNode(imageNamed: "play")
        play.name = "play"
        play.setScale(scale)  // Установка нового масштаба
        play.zPosition = 10.0
        play.position = CGPoint(x: size.width / 2.0, y: size.height * 0.7)  // Новая позиция
        addChild(play)

        // Настройка кнопки 'High Score'
        let highScore = SKSpriteNode(imageNamed: "highscore")
        highScore.name = "highscore"
        highScore.setScale(scale)
        highScore.zPosition = 10.0
        highScore.position = CGPoint(x: size.width / 2.0, y: play.position.y - play.frame.height - 20.0)  // Новая позиция
        addChild(highScore)

        // Настройка кнопки 'Settings'
        let setting = SKSpriteNode(imageNamed: "setting")
        setting.name = "setting"
        setting.setScale(scale)
        setting.zPosition = 10.0
        setting.position = CGPoint(x: size.width / 2.0, y: highScore.position.y - highScore.frame.height - 20.0)  // Новая позиция
        addChild(setting)

        // Настройка кнопки 'Save Results'
        let saveResults = SKSpriteNode(imageNamed: "saveResultButton")
        saveResults.name = "saveResult"
        saveResults.setScale(scale)
        saveResults.zPosition = 10.0
        saveResults.position = CGPoint(x: size.width / 2.0, y: setting.position.y - setting.frame.height - 20.0)  // Новая позиция
        addChild(saveResults)
    }


    func saveResultsFunction() {
        guard let scene = self.scene, let viewController = scene.view?.window?.rootViewController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultsVC = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController {
            resultsVC.modalPresentationStyle = .fullScreen
            viewController.present(resultsVC, animated: true, completion: nil)
        }
    }

    
    func setupPanel() {
        setupContainer()

        let panel = SKSpriteNode(imageNamed: "panel")
                panel.setScale(1.5)
        panel.zPosition = 20.0
        panel.position = .zero
        containerNode.addChild(panel)
        
        //Highscore
        let x = -panel.frame.width/2.0 + 250.0
        let highScoreLabel = SKLabelNode(fontNamed: "Krungthep")
        highScoreLabel.text = "Highscore: \(ScoreGenerator.sharedInstance.getHighScore())"
        highScoreLabel.horizontalAlignmentMode = .left
        highScoreLabel.fontSize = 80.0
        highScoreLabel.zPosition = 25.0
        highScoreLabel.position = CGPoint(x: x, y: highScoreLabel.frame.height/2.0 - 30.0)
        panel.addChild(highScoreLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Krungthep")
        scoreLabel.text = "Score: \(ScoreGenerator.sharedInstance.getScore())"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontSize = 80.0
        scoreLabel.zPosition = 25.0
        scoreLabel.position = CGPoint(x: x, y: -scoreLabel.frame.height - 30.0)
        panel.addChild(scoreLabel)
    }
    
    func setupContainer() {
        containerNode = SKSpriteNode()
        containerNode.name = "container"
        containerNode.zPosition = 15.0
        containerNode.color = .clear //UIColor(white:0.5, alpha: 0.5)
        containerNode.size = size
        containerNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        addChild(containerNode)
    }
    
    func setupSetting() {
        setupContainer()
        
        //Panel
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.setScale(1.5)
        panel.zPosition = 20.0
        panel.position = .zero
        containerNode.addChild(panel)
        
        //Music
        let music = SKSpriteNode(imageNamed: SKTAudio.musicEnable ? "musicOn" : "musicOff")
        music.name = "music"
        music.setScale(0.7)
        music.zPosition = 25.0
        music.position = CGPoint(x: -music.frame.width - 50.0, y: 0.0)
        panel.addChild(music)
        
        //Sound
        let effect = SKSpriteNode(imageNamed: SKTAudio.musicEnable ? "effectOn" : "effectOff")
        effect.name = "effect"
        effect.setScale(0.7)
        effect.zPosition = 25.0
        effect.position = CGPoint(x: music.frame.width + 50.0, y: 0.0)
        panel.addChild(effect)
    }
}
