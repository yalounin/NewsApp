//
//  News.swift
//  NewsApp
//
//  Created by Max Yalounin on 18.07.2020.
//  Copyright © 2020 Max Yalounin. All rights reserved.
//

import UIKit

struct News { // модель одной конкретной новости
    var image: String // имя файла картинки
    var date: String // дата в виде dd/MM/yyyy
    var text: String // текст новости
    var dateValue: Date{ // необходимо для сортировки новостей по дате
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            // если дата записана в некорректном формате, использовать текущую дату
            return formatter.date(from: date) ?? Date()
        }
    }
}


struct NewsList { // список новостей
    var news: [News]
}



// MARK: КОНТЕНТ
extension NewsList {
    static var allNews: [News] {
        return [
            News(image: "image1.jpg", date: "30/06/2020", text: "SEATTLE — Weeks of violent clashes between federal agents and protesters in Portland, Ore., galvanized thousands of people to march through the streets of American cities on Saturday, injecting new life into protests that had largely waned in recent weeks. \nOne of the most intense protests was in Seattle, where a day of demonstrations focused on police violence left a trail of broken windows and people flushing pepper spray from their eyes. At least 45 protesters had been arrested as of early evening, and both protesters and police officers suffered injuries." as String),
            News(image: "image2.jpg", date: "25/07/2020", text: "North Korea has reported what it describes as the country's first suspected case of coronavirus.\nState news agency KCNA said a person who defected to South Korea three years ago last week returned across the demarcation line had Covid-19 symptoms.\nLeader Kim Jong-un held an emergency meeting with top officials, imposing a lockdown in the border city of Kaesong." as String),
            News(image: "image3.jpg", date: "18/07/2020", text: "Hundreds of Thai gay activists have raised rainbow flags in Bangkok during a pro-democracy rally in the capital.\nThey danced and sang in the city centre, where police were deployed. There were no reports of any violence.\nSaturday's rally was the latest in a series of youth-led protests calling for the government to resign.\nGeneral Prayuth Chan-ocha seized power in a coup in 2014, and was later named as prime minister by the military-appointed parliament." as String),
            News(image: "image4.jpg", date: "15/06/2020", text: "In the week that Oxford University announced promising results from its coronavirus vaccine trial, we're looking at claims on social media about vaccines and misleading statements about their safety.\nThe anti-vaccination movement has gained traction online in recent years, and campaigners opposed to vaccination have moved their focus to making claims relating to the coronavirus." as String),
            News(image: "image5.png", date: "28/06/2020", text: "All 68 inmates who escaped from a jail in South Africa's Western Cape on Friday have been rearrested, the government says. Prison officials were praised for \"restoring stability\" following a two-day manhunt.\nThe break-out happened after inmates at Malmesbury Prison \"overpowered\" staff during an exercise session.\nThey then locked three officers in a cell before freeing other prisoners and escaping over a roof, authorities said.\nPrevious reports said they had escaped while being transferred to court for trial.\nSouth Africa's prison body had originally said 69 inmates escaped, but the department of justice on Sunday said they were 68 in total.\nAccording to local news site EWN, the reason for this confusion was that one inmate presumed to have escaped had in fact \"moved to a different cell during the chaos and never left the facility\".\nPart of the escape was caught on camera by a member of the public who was sitting in his car." as String),
            News(image: "image6.jpg", date: "03/06/2020", text: "After years of working in states across the US, engineer and entrepreneur Brian Rice decided he wanted to invest in his hometown of Birmingham, Alabama." as String),
            
        ]
    }
}
