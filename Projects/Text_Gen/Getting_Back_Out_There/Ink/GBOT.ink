VAR season = ""
//Records current season
VAR season_count = 0
// Records number of seasons reader has experienced. On reaching 4, game ends
VAR most_recent_animal = "little wildlife"
//Records the last animal the player saw.
VAR deer_sightings = 0
// Records number of times player has seen deer. - May not be needed? Adding for now.
VAR fawn = false
// Records that player has seen baby deer
VAR rabbit_sightings = 0
//Records number of times player has seen rabbits
VAR kits = false
//Records that player has seen baby rabbits
VAR fox_sightings = 0
//Records number of times player has seen foxes
VAR cubs = false
//Records whether player has seen baby foxes
VAR toad_sightings = 0
//Records number of times the player has seen toads.
VAR tadpoles = false
//Records whether the player has seen tadpoles
VAR glade_visits = 0
//Records number of times player has visited the glade
VAR pond_visits = 0
//Records number of times player has visited the pond
VAR meadow_visits = 0
//Records number of times the player has visited the meadow
VAR path_visits = 0
//Records number of times the player has visited the path
VAR fruit = "none"
//records type of fruit picked
VAR baked = "None" 
//records type of goods baked with fruit
TODO: There's a function mentioned in the handbook that allows limiting of the number of choices shown to the reader - it might be good to implement this once the basic framework is in place
TODO: Add a title page which includes links to Start & Credits
# author: Lynda Clark
# theme: white
-> Start
=== Start ===
# IMAGE: images/Ceiling.png
It's been a long year. You're sick of {~these same four walls|looking up at your cracked ceiling|your own company|life lived through a screen}, sick of {~podcasts|television|videogames|solitaire|jigsaw puzzles|morning yoga|sourdough starters}, sick of your {~heart {~throwing itself against the inside of your chest like it's trying to escape|playing the inside of your ribcage like a xylophone}|thoughts chasing one another like {~foxes after rabbits|lambs around a field|ducklings following their mother|deer during rutting season}}. 
\But finally this morning, the announcement was on the news.
*   You can go outside.

- It's too soon for people. 
* You're not ready. 
- You need to ease into this. {~Baby steps|Take it gradually}. 
\A glance out of the window helps make up your mind. The {~forest|woodland|wood} at the top of the hill. 
\You
*head there immediately.
# CLEAR
- It's {~Spring.->Spring|Summer.->Summer|Autumn.->Autumn|Winter.->Winter}

=== Spring ====
# CLASS: spring 
# IMAGE: images/Spring.png
~ alter(season_count,1)
~ season = "Spring"
{ 
    - season_count > 1: Spring has well and truly sprung.
}
#CLASS: spring 
{~ \There's a light rain falling, ->light_rain|\The sun is shining brightly->sunshine} 

= light_rain
but {~you refuse to let it dampen your spirits.|it's actually rather refreshing.} The {~irridescent black beetles scurrying| {~vibrant purple crocuses|glorious yellow primroses} bursting into bloom} in the undergrowth seem to agree. You
* <span class="spring">duck under the dripping branches{glade_visits >=1: to enter the glade}</span>[]<>. 
    ->glade 
* <span class="spring">squelch over to the treeline {pond_visits >1: to visit the pond once more}</span>[]<>. ->pond
* <span class = "spring">brush through the meadow's damp grass {meadow_visits >=1: again}</span>[]<>. ->meadow
* <span class = "spring">stick to the muddy pathways</span>[]<>. ->path

= sunshine
#CLASS: spring
{~but you have an umbrella in your bag just in case|causing the trees to cast long shadows}. {~Overhead|Above|On high|High in the heavens|Above the treetops}, {~swifts|swallows} swoop and divebomb. After watching them a while, the {~brightness|brilliance|intensity} of the sky hurts your eyes and you're forced to look away. You
* <span class="spring">brush beneath the drooping branches{glade_visits >=1: to reach the glade}</span>[]<>. ->glade
* <span class="spring">leave the sun-dappled path{pond_visits>=1: in favour of the pond}</span>[]<>. ->pond
* <span class="spring">wander across the lush meadow {meadow_visits >=1: again}</span>[]<>. ->meadow
* <span class="spring">follow the daffodil-lined track</span>[]<>. ->path

= glade
#CLASS: spring
~ alter(glade_visits,1)
//My aim was to split each season according to location and animals present. I used the excel chart I created to determine what should go into each conditional block. This should hopefully create a mixture of random generation and curated content consistent with the reader's previous choices in other seasons. It should also be relatively simple to expand, just adding additional blocks and or/locations. I may need to do additional work to increase the randomisation of seeing particular animals, or give this over to the player to control.
{light_rain: \The rain grows heavier, making a pleasing sound on the canopy of trees above.| \The sun is high, but here the treetops lean towards one another conspiratorially, forming a natural den.} # CLASS: spring
{
    - Summer.deer || Autumn.deer || Winter.deer:
        ->deer
    - Summer.fox || Autumn.fox || Winter.fox:
        ->fox
    - Summer.rabbits || Autumn.rabbits || Winter.rabbits:
        -> rabbits
    - light_rain:
        {~->toad|->empty}
    - else:
        {~->fox|->rabbits|->empty}
}

= pond
#CLASS: spring
~alter(pond_visits, 1)
{pond_visits >=2:\You return to the|\You happen upon a} pond, its banks {pond_visits >=2: now} thick with reeds.
{
    - Summer.toad:
    -> toad
    - light_rain:
    {~-> toad|->deer|->empty}
    - sunshine:
    {~->toad|->deer|->fox|->empty}
    - else:
    {~->toad|->deer|->empty}
}

= meadow
#CLASS: spring
~alter(meadow_visits, 1)
\ You stray away from the trees in favour of the expansiveness of the meadow. # CLASS: spring
{
    - light_rain:
    -> empty
    - Summer.deer|| Winter.deer|| Autumn.deer:
    -> deer
    - Summer.rabbits || Winter.rabbits || Autumn.rabbits:
    -> rabbits
    - else:
    {~->empty|->deer|->rabbits}
}

= path
#CLASS: spring
~alter(path_visits, 1)
\ {light_rain: Puddles span the whole path in places, and you wonder whether you should have worn different shoes as you skirt the muddy edges.| The path is barely visible, overgrown with grass and plants, the hedgerows pushing in from either side.} You have a brief vision of yourself as an adventurer braving treacherous conditions and smile at the ridiculousness of the thought. # CLASS: spring
{
    - light_rain:
    {~->toad|->fox|->empty}
    - sunshine:
    {~->fox|->empty}
}

= deer
#CLASS: spring
//May have to change locations to 'came from' depending on how this works...
~ alter(deer_sightings, 1)
~ fawn = true
~ most_recent_animal = "mother deer and her fawn"
A mother deer and a tiny fawn are {pond: lapping at the water}{glade:{light_rain: sheltering from the rain| enjoying the sunsine} in the safety of the glade}{meadow: grazing on the lush grass}. You take care not to startle them and retreat to a distance where you can observe without disturbing them. 

You watch until they move off into the undergrowth {light_rain: twitching raindrops| sunbeams dancing} off their dappled coats. You # CLASS: spring
->Season_end

=fox
#CLASS: spring
~ alter(fox_sightings, 1)
~ cubs = true
~ most_recent_animal = "mother fox and her cubs"
A flash of red catches your eye against the muted greens and browns of the {path:trail|forest}. It's a mother fox and four cubs. {glade:{light_rain: They hurry across the glade, heading for shelter in a denser part of the wood.|The youngsters chase one another in circles, kicking up leaf litter with their rough and tumble play.}{fox_sightings >=2: You wonder if it's the fox from before, now a mother.}} {pond: The mother fox crouches at the water's edge, lapping thirstily with her long pink tongue until {sunshine: her thirst is sated| her coat is slick with rain}. Her cubs tumble around on the bank, {sunshine: panting louder| growing muddier} by the second.}{path:For a moment the mother halts, regarding you with wary amber eyes, and her cubs, unprepared for the sudden stop, careen into her hindquarters.}  You watch, {~captivated|entranced|delighted}, until their mother chases them, nipping at their heels, completely out of sight.

{~Pleased|Elated|Delighted by such an enchanting sight}, you <> # CLASS: spring
-> Season_end

= rabbits
#CLASS: spring
~ alter(rabbit_sightings, 1)
~ kits = true
~ most_recent_animal = "mother rabbit and her kits"
{meadow: A group of rabbits are eating their fill of a clover patch.} It's only when the mother rabbit stirs and sends her youngsters hopping in all directions that they catch your eye. {pond: The mother lingers to drink from the pond, {light_rain: raindrops| sunbeams} dancing on the surface of the water, before joining her kits.} Each kit is a tiny ball of fluff with protruding ears. 

You watch in delight as they disappear into the safety of the treeline, and then you <> # CLASS: spring
->Season_end

=toad
#CLASS: spring
~ alter(toad_sightings, 1)
~ most_recent_animal = "toad"
{pond: 
~ tadpoles = true
~ most_recent_animal = "toad and the tadpoles"
}
{light_rain && glade: You're not the only one taking shelter from the rain, it seems -| You're surprised to see} a large toad is crouching beneath a patch of {pond: bullrushes|dock leaves}. It regards you with large yellow eyes{path: for a moment before hopping across the path and into the dense, dripping foliage beneath the hedgerow}<>. {pond: {light_rain: The rainfall agitates|The sunshine reflects brightly off} the surface of the pond, but you can still make out the dark swishes of tadpoles darting back and forth beneath the water.} Before long {light_rain: the rain has soaked you through| you start to feel hungry} and so you <> # CLASS: spring
->Season_end

= empty
#CLASS: spring
~ temp waterbird = ""
~ waterbird = "{~duck|moorhen|coot}"
{glade:You hear nothing but {light_rain: the soft pattering of rain on leaves and} the bleating of newborn lambs in a neighbouring field.}
{pond: {~ A solitary {waterbird} paddles lazily across the pond. You pat your pockets, wishing you'd brought bread or corn. Fortunately, the {waterbird} doesn't seem to mind.|The pond {light_rain: is filled with ever expanding circles as the rain splashes against its surface|is still and clear as a sheet of glass}.}}
{meadow: The grass is up to your hips in places and {light_rain: as the rain falls steadily, you grow wetter and wetter, your clothes heavier and heavier.| you swat at it with your hands as you walk, making the heavy seeds topping the stems dance and bob.} There's a child-like pleasure in it.}
{path: {light_rain: You press on until the path grows completely waterlogged. |{~ Eventually the hedgerows grow too dense, thick with {~ heavy pink dog roses|the pink and white trumpeting blooms of bindweeds}.|After a while, the hedgerows grow so thick they bar your way, and instead you look up. {~Larks|Swifts|Swallows} wheel overhead, trilling to one another.}}You turn back. A small amount of progress is still progress.}
{~Energised,|Refreshed,|Feeling a little more relaxed,} you <> # CLASS: spring
->Season_end

=== Summer ====
# IMAGE: images/Summer.png
# CLASS: summer
~ alter(season_count, 1)
~ season = "Summer"
{season_count > 1: It is Summer.}
It's only a short walk between here and your home, but you're already feeling sun-baked. # CLASS: summer
\You wonder if you'll see {most_recent_animal == "little wildlife": any wildlife| that {most_recent_animal} again} today. You  # CLASS: summer
* <span class="summer">think the shade of the glade looks inviting<>{glade_visits >=1: as ever}</span>[]<>. ->glade
* <span class="summer">go {pond_visits >=1:back} towards the pond</span>[]<>. -> pond
* \<span class="summer"> {meadow_visits >=1:re<>}visit the meadow</span>[]<>. ->meadow
* <span class="summer">follow the path{path_visits >=1:again}</span>[]<>. ->path

=glade
# CLASS: summer
~ alter(glade_visits, 1)
\The spreading branches of the oaks and sycamores give you some welcome respite from the sun, although the damage may already be done in that regard. Just as you're wishing you'd brought {~a wide-brimmed hat|sunscreen|sunglasses}, <>
{
    - Spring.deer:
        ->deer
    - Spring.fox || Autumn.fox || Winter.fox:
        ->fox
    - Spring.rabbits || Autumn.rabbits || Winter.rabbits:
        -> rabbits
    - Winter.snowman:
    -> empty
    - else:
        {~->empty|->fox|->rabbits}
}
=pond
# CLASS: summer
~alter(pond_visits, 1)
\The water level is low{pond_visits >2:<>er than you've ever seen it}. As you swat away midges, lured in by your warm, sweaty skin, <>
{
- Spring.toad:
    -> toad
- Spring.deer || Autumn.deer || Winter.deer:
    -> deer
- Spring.fox || Autumn.fox || Winter.fox:
    ->fox
- Spring.rabbits:
    ->rabbits
- else:
    {~->empty|->toad|->deer|->fox|->rabbits}
}
=meadow
# CLASS: summer
~alter(meadow_visits, 1)
The sky is {~vibrant|cloudless|intense} {~blue|cyan|cerulean}. {~An osprey|A kite|A buzzard} circles overhead, then swoops low, talons outstretched. {Spring.sunshine:You'd think you would have learned your lesson, but you didn't, and as|As} you look away from the brightness, the image is imprinted on your retina for a while {Spring.sunshine:<>. Blinking,<> |and, blinking furiously, <>}
{
- Spring.deer:
    ->deer
- Spring.rabbits:
    ->rabbits
- Spring.fox:
    ->fox
- else:
    {~ ->empty|->deer|->rabbits|->fox}
}

=path
# CLASS: summer
~alter(path_visits, 1)
You try to shade the back of your neck. The sun is growing a little too {~ intense|fierce|hot}. You notice cow parsley wilting in the hedgerow and think: "Same". The path is baked hard and rings hollow with your steps, until <>
{
- Spring.fox || Autumn.fox || Winter.fox:
    ->fox
- Spring.rabbits || Autumn.rabbits || Winter.rabbits:
    ->rabbits
- else: 
    {~->empty|->rabbits|->fox}
}

=deer
# CLASS: summer
~ alter(deer_sightings, 1)
~ fawn = true
~ most_recent_animal = "mother deer and her fawn"
you realise there are deer here {Spring.glade && Spring.deer:again}, sniffing at the {meadow: buttercups dotting the grass|shoots poking through the leaf litter} with their soft velvety muzzles. You hold your breath. {pond: This must be their regular watering hole - they seem relaxed here.}
\The fawn {Spring.glade && Spring.deer:has almost doubled in size, nearing|nears} the height of its mother. {Spring.glade && Spring.deer:The spots are fading from its coat.} # CLASS: summer
You feel {~elated|delighted|pleased} to have found them {Spring.glade && Spring.deer:again}, and watch them until you realise {~it is time to|you should}<> # CLASS: summer
->Season_end

=fox
# CLASS: summer
~ alter(fox_sightings, 1)
{cubs: 
~ most_recent_animal = "fox and her cubs"
}
{not kits:
~ most_recent_animal = "fox"
}
 you're suprised to see a {most_recent_animal} sprawled {pond: by the water's edge|on the ground} sunning {kits:themselves|itself}. Where the sun catches {kits: their coats|its coat} the fur flares red as fire. {fox_sightings >2: There are some grey hairs in the {kits: mother's|fox's} muzzle now. Your hand drifts to your own hair. You know that feeling.} You smile.
 
 \Just seeing this {kits: happy family|beautiful creature} makes your heart soar. \When {~ the sun finally dips lower| your back begins to ache from being stationary too long}, you<> # CLASS: summer
->Season_end

=rabbits
# CLASS: summer
~ alter(rabbit_sightings, 1)
{kits: 
~ most_recent_animal = "rabbit and her kits"
}
{not kits:
~ most_recent_animal = "rabbit"
}
 you come across a {most_recent_animal} {pond: stretched out by the water|sprawled in a patch of sunlight}, long legs trailing comicly behind. {kits: The kits have grown into their ears. {rabbit_sightings>=2: Assuming they are the same ones you saw before, of course.}} 
\You hang back. {kits: Their noses twitch|Its nose twitches}{meadow: and {kits: their mouths work as they chew|its jaw works as it chews} grass from {kits: their|its} place of repose}<>. {pond: {kits:One|The} rabbit hops to the water's edge and drinks, disturbing a {~goose|swan} which coasts away, honking and fluttering its wings in displeasure.} # CLASS: summer

Everything here is so alive. It makes you feel more alive too. # CLASS: summer

\Vowing to come back again as soon as you can, you <> # CLASS: summer
->Season_end

=toad
# CLASS: summer
~ alter(toad_sightings, 1)
{tadpoles: 
~ most_recent_animal = "toadlets"
}
{not tadpoles:
~ most_recent_animal = "toad"
}
you're startled by movement in the pond. {tadpoles: The water is absolutely teeming with toadlets!|A toad, startled at your approach, slides off a rock and plops into the water.} The {most_recent_animal} won't want for food either - {~waterboatmen|pondskaters|dragonflies} dart across the surface, while {~whirligig beetles|diving beetles|water snails} are just visible beneath the green sheen of the water.

{~Eventually|Finally} you decide you've provided the midges with enough of a feast and <>
->Season_end

= empty
# CLASS: summer
you stumble over a {meadow: grassy hummock|protruding tree root}{path: that has grown across the path}<>. You look around out of habit, but of course there's {pond:only a {~grebe|duck|mallard} or two to witness| no-one to see} your clumsiness here. 
\The grass {season_count>1:has grown|is} thick {glade: in the glade}{pond: around the edges of the pond}{path: on either side of the path}, some patches yellowed by the sun's intensity. You {glade: find a shady spot and} watch a {~chiffchaff|sparrow|nightingale} hop from branch to {path: overhanging} branch {~overhead|above}, trilling{glade:<>. Patches of {~vivid bluebells|dog violets|golden cowslips} provide bursts of colour beneath the trees.} {pond:{~Marsh marigolds trail in the water's edge|Vast white water lilies float on the pond's surface}<>.}{Winter.glade && Winter.snowman: You look at the spot where you built your snowman in Winter. There are forget-me-nots sprouting there now. You didn't forget.} {meadow: {~A {~large bumble bee|bright yellow brimstone butterfly|huge peacock butterfly} alights on {~an ox-eye daisy|some red clover|a fragrant jasmine|an enormous red poppy} in search of nectar| sheep bleats somewhere in the distance and is answered by the bark of a sheep dog}.}{Autumn.berries: The hedgerow is budding with {fruit} again - you should be able to pick another batch soon.}
*<span class="summer">Inhale</span>[].
-Exhale.
Then <>  
->Season_end

=== Autumn ===
# IMAGE: images/Autumn.png
# CLASS: autumn
~ alter(season_count, 1)
~ season = "Autumn"
{season_count > 1: Autumn has arrived.}
{~ \You can't see more than a few feet in front of you thanks to the shroud of mist that's descended. ->mist|\However bright it may be, the air is cool and crisp.->cool}

=mist
# CLASS: autumn
\But you promised yourself you'd get out and about today, so you're doing it, even if it looks like a horror film waiting to happen. 
\Such a silly thought. You're sure # CLASS: autumn
* <span class="autumn">the glade will {glade_visits >=1:still} be beautiful</span>[].->glade
* <span class="autumn">the meadow will be {meadow_visits >=1:just as} tranquil</span>[].->meadow
* <span class="autumn">the pond will be pretty {pond_visits >=1:as ever}</span>[].->pond
* <span class="autumn">the track is {path_visits >=1: still} completely useable</span>[].->path

=cool
#CLASS: autumn
\You can see your breath in the air and amuse yourself on the way up the hill, puffing out clouds, pretending to be a {~dragon|steam {~train|kettle}}. 
\When you reach the {~woodland|forest|woods|treeline}, you decide to # CLASS: autumn
* (fruit_picking)<span class="autumn">scour the hedgerows for fruits and berries</span>[].->path
* <span class="autumn">scuff through the leaves in the glade</span>[].->glade
* <span class="autumn">see what the pond has in store {pond_visits >=1: today}</span>[].->pond
* <span class="autumn">make the most of the weather by {meadow_visits >=1: revisiting| visiting} the meadow</span>[].->meadow

=glade
#CLASS: autumn
~alter(glade_visits, 1)
{mist: The mist deadens all noise,<>|The weak sunlight gives the glade a magical quality,<>}
{
- fawn:
    ->deer
- else:
    {~->deer|->empty}
}

=pond
# CLASS: autumn
~alter(pond_visits, 1)
{~Golden|Orange|Brown|Red} leaves drift on the surface of the water. # CLASS: autumn
{mist: The mist has a muffling effect <>|A sound rings out across the pond- <>} # CLASS: autumn
{
- Summer.toad || Spring.toad:
    {~->toad|->empty}
- fawn:
    {~->deer|->empty}
-else:
    ->empty
}

=meadow
# CLASS: autumn
~alter(meadow_visits, 1)
{mist: The mist rolls low across the grass|The grass of the meadow is decked in dew} and your shoes grow damp as you cross. There's not another living thing in sight<> #CLASS: autumn
{
- (Spring.fox||Summer.fox||Winter.fox) && (Spring.rabbits||Summer.rabbits||Winter.rabbits):
    ->fox
- Spring.rabbits||Summer.rabbits||Winter.rabbits:
    ->rabbits
-fawn:
    ->deer
-else:
    {~->deer|->empty}
}

=path
# CLASS: autumn
~alter(path_visits, 1)
The path's apex {mist: is cloaked in mist| disappears into the dark of the wood}, giving it an eerie quality. {path_visits>=2: But you've been here before - you know where you're going.|An involuntary shiver runs down your spine.} You focus on your shoes on the path, on placing one foot in front of the other, and become fully consumed by the task<> # CLASS: autumn
{
- Spring.fox || Summer.fox || Winter.fox:
    ->fox
-else:
    {~->empty|->fox}
}

=deer
#CLASS: autumn
~ alter(deer_sightings, 1)
{fawn && glade:
~ most_recent_animal = "two rutting stags"
}
{not fawn:
~ most_recent_animal = "lone stag"
}

{glade:{fawn:{mist: which is perhaps why you didn't hear the clashing of their antlers on your way here.| which makes the scene you happen upon all the more otherworldly.} Two stags are locked in combat in the centre of the glade. You remain huddled beneath the trees, holding your breath as they bellow, snort and paw the earth. Eventually the larger of the two drives his rival away, and stands victorious,|{mist: which could be why it doesn't flee at your approach-| making the creature all the more impressive-} a massive stag, its antlers mimicing the tree branches above,} {mist:cutting an ethereal shape| coat steaming} in the centre of the glade.} #CLASS: autumn
{pond: {mist: turning your steps near-silent.| the steady lapping of a thirsty animal.} The stag {cool:still} comes as something of a surprise. {mist:Half-wreathed in mist|Magnificent in the pond's reflected light} its vast antlers almost touch the surface of the water as it drinks deep, {mist: unwitting of|unconcerned by} your presence.} #CLASS: autumn
{meadow: until there is. {mist:Barely visible through the mist -|Little more than a speck on the horizon -} the indistinct shape of a stag grazing. Even {mist: with the deadening effect of the mist|at this distance}. You can hear it plucking at the grass, flat teeth working.}
Your realise you are trembling, but for once it's for a good reason. You are almost dancing as you <> #CLASS: autumn
->Season_end

=fox
# CLASS: autumn
~alter(fox_sightings, 1)
~most_recent_animal = "fox"
{meadow: until a rabbit thunders {mist:out of the mist|past you} and away across the meadow. Hot on its heels comes a fox, lithe and running hard, pink tongue lolling from its mouth. You watch until both {mist: have been enfolded in the mist once more|have disappeared into the treeline} and then<>} #CLASS: autumn
{path:\A shape looms out of the {mist: mist|treeline} and for a moment, your heart batters dizzily against your chest like a bluebottle trying to find a way out. {fruit_picking: Any thoughts of fruit picking are banished in an instant.} But you ->breathe} #CLASS: autumn
->Season_end

=breathe
# CLASS: autumn
*<span class="autumn">take  a deep breath[] </span>and realise it's just a fox, head down, skulking across the path. # CLASS: autumn
{fox_sightings>=2: Perhaps it's the one you saw before{cubs:<>, or one of the cubs, now full grown}<>.} # CLASS: autumn
Relieved, you <> # CLASS: autumn
->Season_end

=rabbits
# CLASS: autumn
~alter(rabbit_sightings, 1)
~most_recent_animal = "pair of rabbits"
until out of nowhere, a flash of brown streaks past you, another hot on its heels. As the bobbing white tail recedes into the {mist:mist|distance} you realise you have borne witness to some kind of rabbit driveby.
Your heart is {~hammering|pounding|thudding|thumping}, but for once in a good way. Smiling, you walk a circuit of the meadow and then <> #CLASS: autumn
->Season_end

=toad
# CLASS: autumn
{mist: but you can still make out} a toad's ribbit. You scour the bank, but can't see it, even though the bullrushes are sparse {pond_visits >=2:now}. Perhaps it's half-buried in the mud. You could do with submerging yourself - a warm bath is in order to combat the chill. Time to<> #CLASS: autumn
->Season_end

=empty
# CLASS: autumn
{mist:<> yet you can still make out the faint calls of a distant {~bird|stag}.|<> which is only enhanced by the cacophony of birdsong that fills the {glade:glade|air}.} The disembodied nature of the sound gives it {mist: an otherworldly| a secret} quality, {cool: as if it is intended just for you,} and the hairs on the back of your neck prickle. 
{glade:{~ You look up at the spreading branches of the oaks and sycamores, their leaves {Spring.glade: once green and lush, now} sparse and red.->empty_end| You kick through the carpet of leaves and are delighted to turn up a conker, <>->conker}} #CLASS: autumn
{pond: {pond_visits >=2: The geese seem to have already migrated for Winter.} A single duck {pond_visits >=2: remains|stands} on the bank, balanced on one orange foot, preening.->empty_end}#CLASS: autumn
{path: {~You stick close to the hedgerows, {~spotting abandoned birds amongst the skeletal branches.->empty_end| admiring the twisting branches of hazel and sharp barbs of hawthorn. Your careful observation is rewarded when->berries|startling a {~wren|robin|sparrow} as it hops through the twisting fretwork of hazel branches and hawthorn barbs.->empty_end|scuffing through the thick patchwork of leaves that have carpeted the track {~for nothing more than the pleasure of doing it->empty_end|until you turn up a conker,->conker}}}}#CLASS: autumn
- ->empty_end

=empty_end
# CLASS: autumn
The days are short{season_count>1:<>er} now and as it grows darker, you know you must<>
->Season_end

=berries
# CLASS: autumn
~ fruit = "{~plum|blackberry|rosehip|sloe}"
you notice a single {fruit} peeping out of the twigs, and, following it with probing fingers, a whole crop! When you get home, you'll make
* (pie) <span class="autumn">a pie</span>[].
* (crumble) <span class="autumn">a crumble</span>[].
* (jam) <span class="autumn">some jam</span>[].
* (gin) <span class="autumn">some gin</span>[].
- You can almost taste it already! Better<>
->Season_end

=conker
# CLASS: autumn
hard and brown and shiny. You pocket it and<>
->Season_end

=== Winter ===
# CLASS: winter
# IMAGE: images/Winter.png
~ alter(season_count, 1)
~ season = "Winter"
{season_count > 1: Winter has descended.}
\Snow has fallen overnight, blanketing everything in whiteness, leaving the world cleaner and colder. As you reach the {~woodland|forest|wood} near your home{season_count >=2: once more}, you wonder # CLASS: winter
*<span class="winter">if {pond_visits >=1:the pond has frozen over|there's anything beyond that thicket}</span>[]<>. ->pond
*<span class="winter">whether anyone has made footprints across the meadow yet</span>[]<>. ->meadow
*<span class="winter">if the snow will have penetrated the glade's trees</span>[]<>. ->glade
*<span class="winter">if the path is icy</span>[]<>.->path

=glade
# CLASS: winter
~alter(glade_visits, 1)
Not only has the snow made it through the trees, it has thickly carpeted the centre of the glade. # CLASS: winter
You could # CLASS: winter
*<span class="winter">build a snowman</span>[]<>. -> snowman
*(footprints)<span class="winter">follow some animal footprints</span>[]<>. 
{
- Autumn.deer || Spring. deer || Summer.deer: 
    ->deer
- else:
    ->empty
}
*(just_enjoy)<span class="winter">just enjoy your surroundings</span>[]<>.->empty

=pond
# CLASS: winter
~alter(pond_visits, 1)
{pond_visits >=2:The pond has indeed|There's a pond here. It's} frozen solid. You tap a cautious toe at the edge. It's thick and feels as slippery and hard as marble, but you still don't fancy your chances in the middle, and anyway, you didn't bring ice skates. # CLASS: winter
{
- Autumn.deer || Spring.deer || Summer.deer: 
    ->deer
- else:
    ->empty
}

=meadow
# CLASS: winter
~alter(meadow_visits, 1)
The meadow has no human footprints and is mostly untouched, rolling out to the fence-line in a smooth white sheet. However, there are animal prints, leading haphazardly towards the trees at the field edge. You decide to # CLASS: winter
*(footprints) <span class="winter">follow the animal tracks</span>[]<>. 
{
- Autumn.rabbits || Spring.rabbits || Summer.rabbits: 
    ->rabbits
- else:
    ->empty
}
*(just_enjoy) <span class="winter">simply make the most of being here</span>[]<>.
->empty

=path
# CLASS: winter
~alter(path_visits, 1)
\The path has its slippery patches, but you can skirt them by 
* (just_enjoy) walking close to the hedgerow[]<>.

{
- Autumn.fox || Spring.fox || Summer.fox:
-> fox
-else:
{~->empty|->fox}
}


=deer
# CLASS: winter
~alter(deer_sightings,1)
{most_recent_animal == "lone stag":
    ~ most_recent_animal = "stag"
- else:
    ~ most_recent_animal="deer"
}
{footprints:You follow the cloven prints, hardly daring to hope, but as you reach the treeline, there it is:} A {most_recent_animal} is picking at some frosty blades of grass poking out of the snow, its breath steaming in the crisp air. {pond: It moves towards the pond's edge, exhales sharply at the frozen surface as if irritated by the lack of easy access to a drink.} {fawn: You wonder if it's the fawn, now full grown. There's no real way of knowing, but you like to imagine that it is.} Eventually it presses further into the wood where the trees are denser, and rather than attempting to follow it, you<>
->Season_end

=fox
# CLASS: winter
~alter(fox_sightings, 1)
~ most_recent_animal = "fox"
Avoiding one particularly treacherous expanse of ice, you notice animal footprints disappearing under the fence. Crouching, you peer into the sparse underbrush and see {Summer.fox && Summer.meadow: a fox with a dead grouse clutched in its jaw|a fox}. It stares at you with yellow eyes. You have a strong desire to reach out and touch it, but resist and withdraw, leaving it to its business and <>
->Season_end

=rabbits
# CLASS: winter
~alter(rabbit_sightings, 1)
~ most_recent_animal = "rabbit"
As you follow the crisp tracks -small, neat forepaws and longer, splayed hindpaws- you think you know what you'll find at the end of them, and you're correct. A lean little rabbit, nose twitching in the crisp air. You stare at one another for a while {rabbit_sightings >=2: and you wonder if it's that same rabbit from earlier, and whether it recognises you}. It doesn't seem concerned by your presence, because it stops to groom itself with its front paws before turning and hopping into the underbrush.

\Time for you to do the human equivalent and <>
->Season_end

=empty
#CLASS : winter
{footprints: The footprints must have belonged to a bird of some kind, because there is no sign of any animal at the end of them - just unblemished snow.}{just_enjoy: The branches of the evergreens above {~are thick with glossy dark green needles|shimmer with frost and long, dripping icicles}.} From the bare branches of a nearby deciduous tree, a {~robin|sparrow|thrush|blackbird} watches you with inquisitive black eyes{path && Autumn.berries:<>, its beak stained with the juice of a late {fruit}}<>. {just_enjoy && meadow: For a moment you're transported back to childhood and run back and forth across the empty expanse peppering it with footprints. There's something deeply satisfying about leaving your mark.} {pond: A lone duck crouches on the far bank, feathers fluffed against the cold.} {Autumn.berries: You think about the {fruit} {Autumn.pie: pie}{Autumn.crumble:crumble}{Autumn.gin:gin}{Autumn.jam:jam} you made a little while ago and how delicious it was.}{pond && Autumn.berries: The thought sends your hand to your pocket and you find {Autumn.pie||Autumn.crumble: a thin sliver of left-over pastry|stale bread} and toss it to the duck. It leaps to its feet and seizes the treat greedily, swallowing it in a single gulp.}{glade_visits >=1 && rabbit_sightings >=1: You think about the {kits:rabbits|rabbit} you saw that time and hope {kits: they have|it has} a safe, warm burrow.}{pond_visits>=1 && toad_sightings >=1: You think about the toad and wonder whether it's buried down in the mud of the pond's bank to keep warm. Do toads hibernate?}{fox_sightings >=1: You think about the fox{cubs: and its cubs}<>, imagine {cubs: them|it} in a den scratched out beneath tree roots,{cubs: tails| tail} curled around {cubs: noses|nose} for warmth.}
\You suddenly become aware of how cold and numb your toes are and<> # CLASS: winter
->Season_end

=snowman
# CLASS: winter
~ temp accessory = ""
~ accessory = "{~scarf|earmuffs|hat}"
You spend a while (maybe too long) rolling two large snowballs for a body and a smaller one for a head. You use a bent twig as a mouth, two pebbles for eyes and {Autumn.conker: the conker from your pocket|a third} for the nose. As a final touch, you remove your {accessory} and {accessory == "scarf":wind it around the snowman's neck|plonk {accessory == "earmuffs":them|it} on the snowman's head}. You snap a quick photo on your phone, and then retrieve the {accessory} and <>
->Season_end

TODO Make sure season count functions properly and that game ends on 4th season.

=== Season_end ===
//This stitch ensures that seasons run from one season to another correctly and ends the story when 4 seasons have been visited. This could be simplified a little using lists, but would still require a similar amount of code, so I stuck with a count for now.
{~ head home| leave the {~wood|woodland|forest}| reluctantly return home| make your way back home}.
+\ {~The world turns.| Days pass.| Time slips through your fingers.|Before you know it...|The hours slide on by.}
#CLEAR
{
    - season_count == 4: 
        ->Year_end
    - season == "Spring": 
                ->Summer
    - season == "Summer": 
                ->Autumn
    - season == "Autumn": 
                ->Winter
    - season == "Winter": 
                ->Spring
}

=== Year_end ===
~ temp most_visited = ""
{- glade_visits>=3:
    ~ most_visited = "the glade"
- else:
    {
    - meadow_visits>=3:
        ~ most_visited = "the meadow"
    - pond_visits>=3:
        ~ most_visited = "the pond"
    - path_visits>=3:
        ~ most_visited = "the pathways"
    - meadow_visits>=2:
        ~ most_visited = "the meadow"
    - pond_visits>=2:
        ~ most_visited = "the pond"
    - path_visits>=2:
        ~ most_visited = "the pathways"
    - else:
        ~ most_visited = "several areas of the woodland"
    }
}
The year is over.

You {season == "Spring":{Spring.light_rain: watch the rain falling outside|pour a cold drink}}{season == "Summer": pour yourself a cold drink}{season == "Autumn":{Autumn.mist:turn up the heating|put your shoes away}}{season == "Winter":crank up the heating as the snow continues to fall steadily outside} and think about the past few months. 
Yes, it's been tough, but you now know {most_visited} like the back of your hand. {most_visited == "several areas of the woodland": Although you couldn't pick a favourite.} 

You saw a {most_recent_animal}, among other things. 

{Winter.snowman: You built a snowman{Autumn.conker: and gave him a conker for a nose}{season == "Winter":<>.|<>. You scroll back through your photos and look at its kindly pebble eyes fondly.}}
{Autumn.berries: You picked {fruit}s and made them into a delicious {Autumn.gin:gin.}{Autumn.pie: pie.}{Autumn.crumble:crumble.}{Autumn.jam:jam.} {season == "Autumn": In fact, you think you'll have some tonight.}}

*But most importantly...

You got back out there.
The End #CLASS: end
->END
TODO Could create some functions to act as smaller generators for individual words as in the original piece.
// e.g. === function syn_completely ===
//{~completely|totally|absolutely}
//Expressed in text as e.g. Oh yeah, {syn_completely()}!

=== function came_from(-> x) 
	~ return TURNS_SINCE(x) == 0
	
=== function alter(ref x, k) ===
	~ x = x + k
