User.create(
  first_name: "Caitlin", last_name: "Hoffman", email: "choff999@gmail.com", password: "password", role: "developer", img: "http://www.thelabradorsite.com/wp-content/uploads/2015/08/when-can-puppy-go-out.jpg"
)

User.create(first_name: "Esther", last_name: "Leytush", email: "eleytush@gmail.com", password: "password", role: "developer",  img:"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAgtAAAAJDZlYzAxN2E3LTVlMjEtNDUyYy04NWExLWQ5M2I5ZjdmNTU3NA.jpg"
)
User.create(
  first_name: "Lisa", last_name: "Buch", email: "lisakbuch@gmail.com", password: "password", role: "developer", img: "https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/6/000/27d/045/11a0c0a.jpg"
)
User.create(
  first_name: "Katherine", last_name: "Broner", email: "katherine.broner@gmail.com", password: "password", role: "developer", img: "https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAkGAAAAJDQ2NjlkYzU2LWVjMzQtNDYyMC1iM2M1LWJlZTVmNTcwZmNmNA.jpg"
)
User.create(
  first_name: "Samantha", last_name: "Holmes", email: "samanthavholmes@gmail.com", password: "password", role: "designer", img: "https://avatars1.githubusercontent.com/u/16512986?v=3&s=460"
)
User.create(
  first_name: "Mike", last_name: "Creative", email: "mike@creativemints.com", password: "password", role: "designer", img: "https://d13yacurqjgara.cloudfront.net/users/13307/avatars/normal/Mike3.jpg?1382537343",
  bio: "Hi! My name is Mike, I'm a creative geek from Prague. I enjoy creating eye candy solutions for web and mobile apps."
)
User.create(
  first_name: "Dan", last_name: "Cenderholm", email: "dan@dribbble.com", password: "password", role: "designer", img: "https://d13yacurqjgara.cloudfront.net/users/1/avatars/normal/0aa00c058835da8e3674f675f88f63c4.jpg?1460392758", bio: "Co-Founder of @dribbble. Designer, author, and speaker at SimpleBits. Dad in real life. Likes ampersands and banjos."
)
User.create(
  first_name: "John", last_name: "Colella", email: "colella.john@gmail.com", password: "password", role: "developer", img: "https://avatars0.githubusercontent.com/u/17008820?v=3&s=460"
)
User.create(
  first_name: "Alana", last_name: "Farkas", email: "alanafarkas@gmail.com", password: "password", role: "developer", img: "https://avatars2.githubusercontent.com/u/15007255?v=3&s=460"
)
User.create(
  first_name: "Ayaz", last_name: "Uddin", email: "ayazuddin@gmail.com", password: "password", role: "developer", img: "https://avatars2.githubusercontent.com/u/15764091?v=3&s=460"
)
User.create(
  first_name: "Christyn", last_name: "Budzyna", email: "cbudzyna@gmail.com", password: "password", role: "developer", img: "https://avatars1.githubusercontent.com/u/10655625?v=3&s=460"
)
User.create(
  first_name: "David", last_name: "Walden", email: "dwalden@gmail.com", password: "password", role: "developer", img: "https://avatars0.githubusercontent.com/u/17076507?v=3&s=460"
)
User.create(
  first_name: "Diana", last_name: "Eromosele", email: "diana@eromosele.com", password: "password", role: "developer",  img: "https://avatars3.githubusercontent.com/u/16394607?v=3&s=460"
)
User.create(
  first_name: "Ena", last_name: "Bek", email: "ebek@gmail.com", password: "password", role: "developer",
  img: "https://avatars0.githubusercontent.com/u/15351103?v=3&s=460"
)
User.create(
  first_name: "Sam", last_name: "Blackman", email: "tsam@gmail.com", password: "password", role: "designer",
  img: "https://avatars0.githubusercontent.com/u/15351103?v=3&s=460"
)
User.create(
  first_name: , last_name: , email: , password: "password", role: "developer", img: ""
)

User.create(
  first_name: "Ted", last_name: "Bogin", email: "tbogin@gmail.com", password: "password", role: "developer",
  img: "https://avatars0.githubusercontent.com/u/16090125?v=3&s=460"
)

# Project.create(title: , description: , tagline: , img: , user_id: )
Project.create(title: "Grocery app that learns your preferences", tagline: "Seeking designer and front-end developer", img: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQuoh55MquxPt6VO7ONbGSboNpMcasFEOS3cAcYw8yxdRXDvz1PDA", user_id: 2, description: "This is a grocery app that will present users with lists that become shorter and more on-point the more they are used, based on which items the user checks off when they go shopping.")

Project.create(title: "Chair rating app", tagline: "Seeking developer and collaborators", img: "http://ep.yimg.com/ay/monticellostore/campeachy-chair-258.jpg", user_id: 4, description: "Ever watch Big Bang Theory? Sheldon got one thing right: your seat matters. Want to build an app that lets you rate chairs.")

Project.create(title: "National Energy", tagline: "Seeking designer", img: "http://cdn.zmescience.com/wp-content/uploads/2015/05/bigstock-Solar-Panel-On-A-Red-Roof-14532428.jpg", user_id: 1, description: "I want to build a data aggregation app that shows which energy sources are being funded in the United States, by what agents, and maybe some media included to educate users.")

Project.create(title: "Media Imaginator", tagline: "Seeking designer and front-end developer", img: "http://img04.deviantart.net/2ab3/i/2013/251/7/0/your_book__your_imagination_by_mikropolka-d6lihtj.jpg", description: "There's no app out there that lets you curate your own front-end page that shares the experience of reading, watching a movie, or listening to a song. I envision an app that bases itself on templates and allows a non-technical user to curate images, text, sounds, colors, and visuals to share with others the subjective and personal experience of media.", user_id: 3)

Project.create(title: "OnTheWay", tagline: "Seeking front-end designer", img: "http://a.abcnews.com/images/Lifestyle/HT_food_maps_usa_jtm_140313_16x13_1600.jpg", description: "Ever go on a roadtrip and get stuck in the middle of the road trying to find somewhere to eat? I want this app to meet that need by helping users find high-rated restaurants on their way.", user_id: 5)

Project.create(title: "Bookshelf", tagline: "A borrower's joy", img: "http://www.awesomeinventions.com/wp-content/uploads/2014/11/read-more-bookshelf.jpg", user_id: 9, description: "A place to aggregate your collection and track which of your books are being borrowed. Your friends can sign up too, and see which of your books they're borrowing!")

Project.create(title: "Minimalist", tagline: "Seeking designer", img: "http://cdn.foregroundweb.com/wp-content/uploads/2014/07/minimalism_featured_image.jpg", description: "Want to build an app that connects you with the rich world of minimalist media--in a minimalist way. Target user base is both people who are just curious and want to learn more, and those who are lifestyle minimalists.", user_id: 2)

Project.create(title: "You, Developer", tagline: "Seeking pro-bono designer for non-profit build", description: "This is a platform that will support a non-profit in sending out grant proposals to tech companies and government agencies, and connect with in-need individuals to grant them scholarships, stipends, computers, and child care services so that they can attend coding programs and change their lives.", user_id: 10, img: "http://beachcoders.com/wp-content/uploads/2015/05/beach-slide.jpg")

Project.create(title: "Google trends API", tagline: "Seeking collaborative developers", description: "Google Trends aren't a real API, there's only a way to interface with it by browser. Let's build a proper API that allows computers to make those calls for data.", user_id: 11, img: "https://cdn2.hubspot.net/hub/333468/file-1686843511-jpg/blog-images/Google-Trends-Inturact.jpg")

Project.create(title: "StackForYourself", tagline: "Seeking developer", description: "Coding bootcamps are creatively disrupting the technical community and allowing tons of people to enter programming. But they're expensive in time and dedication. As an alternative, people suggest you self-teach from books...or sign up for Free Code Camp, take Coursera and Codecademy, and go through the Odin Project. These are awesome but do not fully meet the need for diverse technical offerings that provide high quality and low or no cost. I want to build Stack For Yourself, which is a complete curriculum to take you to a junior fullstack developer level at your own pace, allowing you to track your progress and connect to a community that is working side-by-side with you.", user_id: 12, img: "https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2014/08/1409261668002.png")

Project.create(title: "Ruby Talks", tagline: "Seeking designer", description: "I want to build a suggestion box for Ruby talks, a place to share talks, and a place to make comments on talks or ideas.", user_id: 15, img: "http://onebyte.biz/wp-content/uploads/2016/04/rubylang.png")
