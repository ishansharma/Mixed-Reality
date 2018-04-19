//
//  ViewController.swift
//  Mixed Reality
//
//  Created by Ishan Sharma on 4/12/18.
//  Copyright © 2018 Ishan Sharma. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    var boxNode: SCNNode?
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin
        sceneView.showsStatistics = true
        setupLighting()
        addSphere()
        addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSphere() {
        let sphere = SCNSphere(radius: 0.1)
        
        let sphereNode = SCNNode()
        sphereNode.geometry = sphere
        sphereNode.position = SCNVector3(0, 0, -0.2)
        
        sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    func setupLighting() {
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
    }

    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {return}
        node.removeFromParentNode()
    }
}

