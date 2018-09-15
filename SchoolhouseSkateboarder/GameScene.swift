//
//  GameScene.swift
//  SchoolhouseSkateboarder
//
//  Created by Gennadiy Glotov on 16.09.2018.
//  Copyright © 2018 Gennadiy Glotov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        //установка привязки координат сцены в левый нижний угол
        anchorPoint = CGPoint.zero
        
        //создает спрайт background
        let background = SKSpriteNode(imageNamed: "background")
        //записываем координаты центра экрана телефона
        let xMid = frame.midX
        let yMid = frame.midY
        //размещаем спрайт backgraund в центре экрана
        background.position = CGPoint(x: xMid, y: yMid)
        //добавляем спрайт в сцену
        addChild(background)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
