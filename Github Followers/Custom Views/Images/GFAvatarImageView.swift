//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 11/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: "avatar-placeholder")
        translatesAutoresizingMaskIntoConstraints = false
    }

    func loadImage(from url: String) {
        let cache = NetworkManager.shared.cache
        let urlString = NSString(string: url)

        if let cachedImage = cache.object(forKey: urlString) {
            image = cachedImage
            return
        }

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }

            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: urlString)

            DispatchQueue.main.async {
                self.image = image
            }

            }).resume()
    }
}
