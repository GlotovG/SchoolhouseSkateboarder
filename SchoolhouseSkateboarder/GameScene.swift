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
    
    // Массив, содержащий все текущие секции тротуара
    var bricks = [SKSpriteNode]()
    
    // Размер секций на тротуаре
    var brickSize = CGSize.zero
    
    // Настройка скорости движения направо для игры
    // Это значение может увеличиваться по мере продвижения пользователя в игре
    var scrollSpeed: CGFloat = 5.0
    
    // Здесь мы создаем героя игры - скейтбордистку
    let skater = Skater(imageNamed: "skater")
    
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
        
        // Настраиваем свойства скейтбордистки и добавляем ее в сцену
        resetSkater()
        //добавляем спрайт скейтерши в сцену
        addChild(skater)
        
    }
    
    func resetSkater() {
        // Задаем начальное положение скейтбордистки, zPosition и minimumY
        let skaterX = frame.midX / 2.0
        /*
        Задавая положение спрайта, мы также фактически задаем местопо- ложение его центра. Таким образом, если поместить спрайт по оси y в точку 0.0, одна половина его останется на экране, а вторая не будет видна. Поэтому, чтобы поместить объект в нижней части экрана (но чтобы он остался в его пределах), нам нужно задать положение y на уровне половины его высоты. И, наконец, чтобы учесть высоту нашего тротуара, которая равна 64 пикселям, мы добавляем 64 к положе- нию y скейтбордистки.
        */
        let skaterY = skater.frame.height / 2.0 + 64.0
        //Теперь, когда мы рассчитали координаты скейтбордист- ки по осям x и y, задаем ее начальное положение путем создания CGPoint, который принимает эти значения
        skater.position = CGPoint(x: skaterX, y: skaterY)
        //Поскольку нужно, чтобы наша скейтбордистка находилась перед фоновым изображением, устанавливаем для нее значение zPosition, равное 10. Таким образом, у нас остается некоторое пространство, чтобы поместить другие объекты между скейтбордисткой и фоном.
        skater.zPosition = 10
        //мы задаем для свойства minimumY спрайта skater значение, равное ее положению по y. В ходе игры скейтбордистка будет прыгать, поэтому ее положение по y изменится, однако теперь наша переменная minimumY будет показывать, чему равно ее положе- ние на земле
        skater.minimumY = skaterY
    }
    
    func spawnBrick (atPosition position: CGPoint) -> SKSpriteNode {
        // Создаем спрайт секции и добавляем его к сцене
        //Создаем спрайт brick в виде SKSpriteNode с использованием изображения sidewalk.png
        let brick = SKSpriteNode(imageNamed: "sidewalk")
        //новый спрайт brick помещается в положение, ранее переданное в метод
        brick.position = position
        //спрайт brick получает значение zPosition, равное 8
        brick.zPosition = 8
        //После этого наш объект brick добавляется к сцене (в противном случае он просто не покажется на экране)
        addChild(brick)
        
        // Обновляем свойство brickSize реальным значением размера секции
        brickSize = brick.size
        // Добавляем новую секцию к массиву
        bricks.append(brick)
        // Возвращаем новую секцию вызывающему коду
        return brick
    }
    
    func updateBricks(withScrollAmount currentScrollAmount: CGFloat) {
        
        // Отслеживаем самое большое значение по оси x для всех 8 существующих секций
        var farthestRightBrickX: CGFloat = 0.0
        
        //обходит весь массив bricks с помощью цик- ла for-in
        for brick in bricks {
            //рассчитывается новое положение по оси x для спрайта brick. Для этого мы вычитаем из значения положения на оси x значение currentScrollAmount. Новое значение newX соответствует новому положению, находящемуся немного левее от текущего положения секции
            let newX = brick.position.x - currentScrollAmount
            // Если секция сместилась слишком далеко влево (за пределы 8 экрана), удалите ее
            //мы используем выражение if, чтобы проверить, оказалось ли значение newX секции за пределами экрана. Для этого смотрим, меньше ли это значение, чем ширина секции со знаком «минус» (–brickSize.width)
            if newX < -brickSize.width {
                //Для удаления любого спрайта из сцены мы вызываем метод removeFromParent()
                brick.removeFromParent()
                //В процессе удаления спрайта brick мы должны удалить его из массива bricks, поскольку нам нужно, чтобы этот массив содер- жал лишь секции, видимые на экране
                if let brickIndex = bricks.index(of: brick) {
                    bricks.remove(at: brickIndex)
                } else {
                    //задает новое положение относительно оси x для спрайта brick путем создания CGPoint на основе уже рассчитанного нами значения newX. Мы хотим, чтобы секции двигались только влево, а не вверх или вниз, поэтому не будем менять их положение по оси y.
                    // Для секции, оставшейся на экране, обновляем положение
                    brick.position = CGPoint(x: newX, y: brick.position.y)
                    //Обновляем значение для крайней правой секции
                    if brick.position.x > farthestRightBrickX {
                        farthestRightBrickX = brick.position.x
                    }
                }
            }
        }
        
        // Цикл while, обеспечивающий постоянное наполнение экрана 8 секциями
        while farthestRightBrickX < frame.width {
            var brickX = farthestRightBrickX + brickSize.width + 1.0
            let brickY = brickSize.height / 2.0
            
            // Время от времени мы оставляем разрывы, через которые 8 герой должен перепрыгнуть
            let randomNumber = arc4random_uniform(99)
            if randomNumber < 5 {
                // 5-процентный шанс на то, что у нас возникнет разрыв между секциями
                let gap = 20.0 * scrollSpeed
                brickX += gap
                // Добавляем новую секцию и обновляем положение самой правой
                let newBrick = spawnBrick(atPosition: CGPoint(x: brickX, y: brickY))
                farthestRightBrickX = newBrick.position.x
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
