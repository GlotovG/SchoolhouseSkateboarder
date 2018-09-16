//
//  Skater.swift
//  SchoolhouseSkateboarder
//
//  Created by Gennadiy Glotov on 16.09.2018.
//  Copyright © 2018 Gennadiy Glotov. All rights reserved.
//

import SpriteKit

class Skater: SKSpriteNode {
    
    //Эта переменная обо- значает скорость, она будет отслеживать скорость перемещения скейтбордистки по оси x (слева направо) и оси y (сверху вниз). К при- меру, когда скейтбордистка подпрыгивает, значение скорости по y будет определять, насколько быстро она движется вверх.
    var velocity = CGPoint.zero
    //Переменная minimumY — это CGFloat, которую мы используем для уточнения положения уровня земли по y
    var minimumY: CGFloat = 0.0
    //Переменная jumpSpeed — это CGFloat, которая задает, с какой скоростью может прыгнуть скейтбордистка. Мы используем изна- чальное значение скорости, равное 20.0
    var jumpSpeed: CGFloat = 20.0
    //Переменная isOnGround имеет тип Bool, и мы будем использо- вать ее для отслеживания, находится ли скейтбордистка на земле
    var isOnGround = true

}
