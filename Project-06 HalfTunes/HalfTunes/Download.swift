//
//  Download.swift
//  HalfTunes
//
//  Created by fengdaq on 2019/3/29.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  var track: Track
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  var progress: Float = 0
  
  init(track: Track) {
    self.track = track
  }
}
