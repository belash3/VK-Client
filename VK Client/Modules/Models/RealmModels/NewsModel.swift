// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? newJSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - News
class News: Codable {
    let response: NewsResponse

    init(response: NewsResponse) {
        self.response = response
    }
}

// MARK: - Response
class NewsResponse: Codable {
    let items: [NewsItem]?
    let groups: [NewsGroup]?
    let profiles: [Profile]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }

    init(items: [NewsItem]?, groups: [NewsGroup]?, profiles: [Profile]?, nextFrom: String?) {
        self.items = items
        self.groups = groups
        self.profiles = profiles
        self.nextFrom = nextFrom
    }
}

// MARK: - Group
class NewsGroup: Codable {
    let isMember, id: Int?
    let photo100: String?
    let isAdvertiser, isAdmin: Int?
    let photo50, photo200: String?
    let type: GroupType?
    let screenName, name: String?
    let isClosed: Int?

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }

    init(isMember: Int?, id: Int?, photo100: String?, isAdvertiser: Int?, isAdmin: Int?, photo50: String?, photo200: String?, type: GroupType?, screenName: String?, name: String?, isClosed: Int?) {
        self.isMember = isMember
        self.id = id
        self.photo100 = photo100
        self.isAdvertiser = isAdvertiser
        self.isAdmin = isAdmin
        self.photo50 = photo50
        self.photo200 = photo200
        self.type = type
        self.screenName = screenName
        self.name = name
        self.isClosed = isClosed
    }
}

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}

// MARK: - Item
class NewsItem: Codable {
    let donut: Donut?
    let comments: Comments?
    let canSetCategory: Bool?
    let isFavorite: Bool?
    let shortTextRate: Double?
    let likes: Likes?
    let reposts: Reposts?
    let type, postType: PostTypeEnum?
    let carouselOffset: Int?
    let date, sourceID: Int?
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds, postID: Int?
    let postSource: PostSource?
    let views: Views?
    let topicID: Int?
    let copyright: Copyright?
    let signerID: Int?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case carouselOffset = "carousel_offset"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views
        case topicID = "topic_id"
        case copyright
        case signerID = "signer_id"
    }

    init(donut: Donut, comments: Comments, canSetCategory: Bool?, isFavorite: Bool, shortTextRate: Double, likes: Likes, reposts: Reposts, type: PostTypeEnum, postType: PostTypeEnum, carouselOffset: Int?, date: Int, sourceID: Int, text: String, canDoubtCategory: Bool?, attachments: [Attachment], markedAsAds: Int, postID: Int, postSource: PostSource, views: Views, topicID: Int?, copyright: Copyright?, signerID: Int?) {
        self.donut = donut
        self.comments = comments
        self.canSetCategory = canSetCategory
        self.isFavorite = isFavorite
        self.shortTextRate = shortTextRate
        self.likes = likes
        self.reposts = reposts
        self.type = type
        self.postType = postType
        self.carouselOffset = carouselOffset
        self.date = date
        self.sourceID = sourceID
        self.text = text
        self.canDoubtCategory = canDoubtCategory
        self.attachments = attachments
        self.markedAsAds = markedAsAds
        self.postID = postID
        self.postSource = postSource
        self.views = views
        self.topicID = topicID
        self.copyright = copyright
        self.signerID = signerID
    }
}

// MARK: - Attachment
class Attachment: Codable {
    let type: AttachmentType
    let photo: LinkPhoto?
    let video: AttachmentVideo?
    let audio: Audio?
    let link: Link?
    let doc: Doc?

    init(type: AttachmentType, photo: LinkPhoto?, video: AttachmentVideo?, audio: Audio?, link: Link?, doc: Doc?) {
        self.type = type
        self.photo = photo
        self.video = video
        self.audio = audio
        self.link = link
        self.doc = doc
    }
}

// MARK: - Audio
class Audio: Codable {
    let id, albumID: Int
    let storiesAllowed, storiesCoverAllowed: Bool
    let trackCode: String
    let url: String
    let title: String
    let ownerID, date: Int
    let shortVideosAllowed: Bool
    let genreID: Int?
    let duration: Int
    let artist: String
    let isExplicit, isFocusTrack: Bool
    let subtitle: String?
    let mainArtists: [MainArtist]?
    let lyricsID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case storiesAllowed = "stories_allowed"
        case storiesCoverAllowed = "stories_cover_allowed"
        case trackCode = "track_code"
        case url, title
        case ownerID = "owner_id"
        case date
        case shortVideosAllowed = "short_videos_allowed"
        case genreID = "genre_id"
        case duration, artist
        case isExplicit = "is_explicit"
        case isFocusTrack = "is_focus_track"
        case subtitle
        case mainArtists = "main_artists"
        case lyricsID = "lyrics_id"
    }

    init(id: Int, albumID: Int, storiesAllowed: Bool, storiesCoverAllowed: Bool, trackCode: String, url: String, title: String, ownerID: Int, date: Int, shortVideosAllowed: Bool, genreID: Int?, duration: Int, artist: String, isExplicit: Bool, isFocusTrack: Bool, subtitle: String?, mainArtists: [MainArtist]?, lyricsID: Int?) {
        self.id = id
        self.albumID = albumID
        self.storiesAllowed = storiesAllowed
        self.storiesCoverAllowed = storiesCoverAllowed
        self.trackCode = trackCode
        self.url = url
        self.title = title
        self.ownerID = ownerID
        self.date = date
        self.shortVideosAllowed = shortVideosAllowed
        self.genreID = genreID
        self.duration = duration
        self.artist = artist
        self.isExplicit = isExplicit
        self.isFocusTrack = isFocusTrack
        self.subtitle = subtitle
        self.mainArtists = mainArtists
        self.lyricsID = lyricsID
    }
}

// MARK: - MainArtist
class MainArtist: Codable {
    let name, id, domain: String

    init(name: String, id: String, domain: String) {
        self.name = name
        self.id = id
        self.domain = domain
    }
}

// MARK: - Doc
class Doc: Codable {
    let accessKey: String
    let id: Int
    let ext, title: String
    let size, date: Int
    let preview: Preview
    let type, ownerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case id, ext, title, size, date, preview, type
        case ownerID = "owner_id"
        case url
    }

    init(accessKey: String, id: Int, ext: String, title: String, size: Int, date: Int, preview: Preview, type: Int, ownerID: Int, url: String) {
        self.accessKey = accessKey
        self.id = id
        self.ext = ext
        self.title = title
        self.size = size
        self.date = date
        self.preview = preview
        self.type = type
        self.ownerID = ownerID
        self.url = url
    }
}

// MARK: - Preview
class Preview: Codable {
    let photo: PreviewPhoto
    let video: VideoElement

    init(photo: PreviewPhoto, video: VideoElement) {
        self.photo = photo
        self.video = video
    }
}

// MARK: - PreviewPhoto
class PreviewPhoto: Codable {
    let sizes: [VideoElement]?

    init(sizes: [VideoElement]?) {
        self.sizes = sizes
    }
}

// MARK: - VideoElement
class VideoElement: Codable {
    let type: SizeType?
    let width: Int
    let src: String?
    let height: Int
    let fileSize: Int?
    let url: String?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case type, width, src, height
        case fileSize = "file_size"
        case url
        case withPadding = "with_padding"
    }

    init(type: SizeType?, width: Int, src: String?, height: Int, fileSize: Int?, url: String?, withPadding: Int?) {
        self.type = type
        self.width = width
        self.src = src
        self.height = height
        self.fileSize = fileSize
        self.url = url
        self.withPadding = withPadding
    }
}

enum SizeType: String, Codable {
    case d = "d"
    case i = "i"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Link
class Link: Codable {
    let isFavorite: Bool
    let title: String
    let url: String
    let linkDescription: String
    let target, caption: String?
    let photo: LinkPhoto?

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, url
        case linkDescription = "description"
        case target, caption, photo
    }

    init(isFavorite: Bool, title: String, url: String, linkDescription: String, target: String?, caption: String?, photo: LinkPhoto?) {
        self.isFavorite = isFavorite
        self.title = title
        self.url = url
        self.linkDescription = linkDescription
        self.target = target
        self.caption = caption
        self.photo = photo
    }
}

// MARK: - LinkPhoto
class LinkPhoto: Codable {
    let albumID, id, date: Int?
    let text: String?
    let userID: Int?
    let sizes: [Size]?
    let hasTags: Bool?
    let ownerID: Int?
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }

    init(albumID: Int?, id: Int, date: Int?, text: String?, userID: Int?, sizes: [Size]?, hasTags: Bool?, ownerID: Int?, accessKey: String?, postID: Int?) {
        self.albumID = albumID
        self.id = id
        self.date = date
        self.text = text
        self.userID = userID
        self.sizes = sizes
        self.hasTags = hasTags
        self.ownerID = ownerID
        self.accessKey = accessKey
        self.postID = postID
    }
}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
}

// MARK: - AttachmentVideo
class AttachmentVideo: Codable {
    let ownerID: Int
    let title: String
    let canAdd, duration: Int
    let image: [VideoElement]
    let isFavorite: Bool
    let views: Int
    let type: AttachmentType
    let canLike, canComment: Int
    let firstFrame: [VideoElement]
    let date, id, height: Int
    let trackCode: String
    let width, canAddToFaves: Int
    let accessKey: String
    let comments: Int?
    let canSubscribe, canRepost: Int
    let videoDescription: String
    let videoRepeat: Int?

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image
        case isFavorite = "is_favorite"
        case views, type
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame = "first_frame"
        case date, id, height
        case trackCode = "track_code"
        case width
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case videoDescription = "description"
        case videoRepeat = "repeat"
    }

    init(ownerID: Int, title: String, canAdd: Int, duration: Int, image: [VideoElement], isFavorite: Bool, views: Int, type: AttachmentType, canLike: Int, canComment: Int, firstFrame: [VideoElement], date: Int, id: Int, height: Int, trackCode: String, width: Int, canAddToFaves: Int, accessKey: String, comments: Int?, canSubscribe: Int, canRepost: Int, videoDescription: String, videoRepeat: Int?) {
        self.ownerID = ownerID
        self.title = title
        self.canAdd = canAdd
        self.duration = duration
        self.image = image
        self.isFavorite = isFavorite
        self.views = views
        self.type = type
        self.canLike = canLike
        self.canComment = canComment
        self.firstFrame = firstFrame
        self.date = date
        self.id = id
        self.height = height
        self.trackCode = trackCode
        self.width = width
        self.canAddToFaves = canAddToFaves
        self.accessKey = accessKey
        self.comments = comments
        self.canSubscribe = canSubscribe
        self.canRepost = canRepost
        self.videoDescription = videoDescription
        self.videoRepeat = videoRepeat
    }
}

// MARK: - Comments
class Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }

    init(count: Int, canPost: Int, groupsCanPost: Bool?) {
        self.count = count
        self.canPost = canPost
        self.groupsCanPost = groupsCanPost
    }
}

// MARK: - Copyright
class Copyright: Codable {
    let link: String
    let type, name: String

    init(link: String, type: String, name: String) {
        self.link = link
        self.type = type
        self.name = name
    }
}

// MARK: - Donut
class Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }

    init(isDonut: Bool) {
        self.isDonut = isDonut
    }
}

// MARK: - Likes
class Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }

    init(canLike: Int, canPublish: Int, count: Int, userLikes: Int) {
        self.canLike = canLike
        self.canPublish = canPublish
        self.count = count
        self.userLikes = userLikes
    }
}

// MARK: - PostSource
class PostSource: Codable {
    let type: PostSourceType
    let platform: String?

    init(type: PostSourceType, platform: String?) {
        self.type = type
        self.platform = platform
    }
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Reposts
class Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(count: Int, userReposted: Int) {
        self.count = count
        self.userReposted = userReposted
    }
}

// MARK: - Views
class Views: Codable {
    let count: Int

    init(count: Int) {
        self.count = count
    }
}

// MARK: - Profile
class Profile: Codable {
    let canAccessClosed: Bool?
    let screenName: String?
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?
    let onlineMobile, onlineApp: Int?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
    }

    init(canAccessClosed: Bool?, screenName: String?, online: Int, id: Int, photo100: String, lastName: String, photo50: String, onlineInfo: OnlineInfo, sex: Int, isClosed: Bool?, firstName: String, deactivated: String?, onlineMobile: Int?, onlineApp: Int?) {
        self.canAccessClosed = canAccessClosed
        self.screenName = screenName
        self.online = online
        self.id = id
        self.photo100 = photo100
        self.lastName = lastName
        self.photo50 = photo50
        self.onlineInfo = onlineInfo
        self.sex = sex
        self.isClosed = isClosed
        self.firstName = firstName
        self.deactivated = deactivated
        self.onlineMobile = onlineMobile
        self.onlineApp = onlineApp
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let appID, lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case appID = "app_id"
        case lastSeen = "last_seen"
    }

    init(visible: Bool, isMobile: Bool, isOnline: Bool, appID: Int?, lastSeen: Int?) {
        self.visible = visible
        self.isMobile = isMobile
        self.isOnline = isOnline
        self.appID = appID
        self.lastSeen = lastSeen
    }
}
