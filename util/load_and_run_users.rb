#!/usr/bin/ruby
require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

users=  ["ladygaga","justinbieber","katyperry","shakira","KimKardashian","britneyspears",
"rihanna","BarackObama","taylorswift13","selenagomez","aplusk","TheEllenShow","Oprah",
"YouTube","NICKIMINAJ","Eminem","KAKA","jtimberlake","twitter_es","twitter","chrisbrown",
"Pink","BrunoMars","Cristiano","charliesheen","TwitPic","JimCarrey","kanyewest","cnnbrk",
"SnoopDogg","ParisHilton","ashleytisdale","RyanSeacrest","KhloeKardashian","aliciakeys",
"50cent","ddlovato","MariahCarey","coldplay","Drake","UberSoc","BillGates","tyrabanks",
"LilTunechi","ivetesangalo","KourtneyKardash","ricky_martin","SHAQ","programapanico",
"ConanOBrien","jimmyfallon","iamdiddy","LucianoHuck","mrskutcher","MileyCyrus",
"chelseahandler","JessicaSimpson","danieltosh","PerezHilton","AlejandroSanz",
"RealWizKhalifa","JLo","nytimes","snooki","google","ClaudiaLeitte","juanes",
"rustyrockets","rafinhabastos","Ludacris","noaheverett","NBA","eonline",
"stephenfry","nickjonas","AvrilLavigne","TreySongz","106andpark","CNN",
"Calle13Oficial","BreakingNews","SabrinaSatoReal","JonasBrothers","snaptu",
"DalaiLama","TheOnion","Anahi","marcosmion","twitcam","OfficialAdele","davidguetta",
"MrsLRCooper","marcoluque","KingJames","peoplemag","OMGFacts","souljaboy",
"lancearmstrong","tomhanks","time"]

puts "Running..."
# For each domain
users.each do |user| 
  puts "trying #{user}"
  begin 

    # create the user entity
    u = Tapir::Entities::User.create :usernames => [user]
    u.run_task "twitpic_photo_locations"

  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
puts "Done."
