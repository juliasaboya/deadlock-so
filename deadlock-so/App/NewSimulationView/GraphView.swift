//
//  GraphView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 28/07/25.
//

import SwiftUI

func split<T>(_ array: [T]) -> ([T], [T]) {
    let half = array.count / 2
    return (Array(array[0..<half]), Array(array[half..<array.count]))
}

struct GraphView: View {
    var resources: [Resource]
    var processes: [ProcessThread]
    var availableResources: [ResourceSemaphore]
    var leftResources: [Resource]
    var rightResources: [Resource]
    var leftAvailable: [ResourceSemaphore]
    var rightAvailable: [ResourceSemaphore]


    init(resources: [Resource], availableResources: [ResourceSemaphore], processes: [ProcessThread]) {
        self.resources = resources
        self.availableResources = availableResources
        self.processes = processes

        let (leftResources, rightResources) = split(resources)
        let (leftAvailable, rightAvailable) = split(availableResources)

        self.leftResources = leftResources
        self.rightResources = rightResources
        self.leftAvailable = leftAvailable
        self.rightAvailable = rightAvailable
    }



    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: proxy.size.height * 0.18) {
                HStack(spacing: 0.02 * proxy.size.width) {
                    ForEach(Array(leftResources.enumerated()), id: \.offset) { index, resource in
                        ResourceView(
                            resource: resource,
                            availableResources: [leftAvailable[index]],
                            width: proxy.size.width * 0.15,
                            totalHeight: proxy.size.height * 0.1
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                HStack(spacing: 0.01 * proxy.size.width) {
                    ForEach(processes, id: \.self){
                        process in
                        SingleProcessView(process: process, circleDiameter: proxy.size.width/12)
                    }
                }
                HStack(spacing: 0.02 * proxy.size.width) {
                    ForEach(Array(rightResources.enumerated()), id: \.offset) { index, resource in
                            ResourceView(
                                resource: resource,
                                availableResources: [rightAvailable[index]],
                                width: proxy.size.width * 0.15,
                                totalHeight: proxy.size.height * 0.1
                            )
                        }
                }
                .frame(maxWidth: .infinity)
            }

        }
    }
}

