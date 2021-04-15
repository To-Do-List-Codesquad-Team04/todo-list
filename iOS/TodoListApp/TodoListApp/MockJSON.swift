//
//  MockJSON.swift
//  TodoListApp
//
//  Created by Song on 2021/04/12.
//

import Foundation

struct MockJSON {
    static let json = """
    [
        {
            "id": 1,
            "title": "GitHub 공부하기",
            "contents": "add, commit, push",
            "createDate": "2021-04-10 12:00:00",
            "todo": true,
            "doing": false,
            "done": false
        },
        {
            "id": 2,
            "title": "HTML/CSS 공부하기",
            "contents": "* GitHub 공부내용\\n* 모던 자바스크립트 1장 공부내용",
            "createDate": "2021-04-11 12:00:00",
            "todo": false,
            "doing": true,
            "done": false
        },
        {
            "id": 3,
            "title": "블로그에 포스팅할 것",
            "contents": "input 태그 실습",
            "createDate": "2021-04-12 12:00:00",
            "todo": true,
            "doing": false,
            "done": false
        }
    ]
    """.data(using: .utf8)!
}
