n_inc = 0.001
p_val = 0
x = 0
y = 0
angle = 0
phase = 0
n_frames = 20.0
phase_inc = 1 / n_frames

def setup():
    global x
    global y
    
    size(500, 500)
    x = width / 2.0
    y = height / 2.0
    noStroke();
    colorMode(HSB)
    noiseSeed(5)
        
def draw():
    global p_val
    global phase
    global phase_inc
    global x
    global y
    global angle
    
    background(32)
    this_phase = phase

    for i in xrange(40000):
        fill(map(sin(this_phase * TWO_PI), -1, 1, 0, 255))        
        this_phase += phase_inc * 0.25
        if this_phase > 1.0:
            this_phase -= 1.0
        draw_walker()            

    phase += phase_inc
    if phase > 1.0:
        phase -= 1.0
    p_val = 0
    angle = 0
    x = width / 2.0
    y = height / 2.0
    
def draw_walker():
    global x
    global y
    global p_val
    global pInc
    global angle
    
    angle += noise(p_val) - 0.5
    p = PVector.fromAngle(angle)
    x += p.x
    y += p.y
    
    if x < 0:
        x += width
    elif x >= width:
        x -= width
    if y < 0:
        y += height
    elif y >= height:
        y -= height

    ellipse(x, y, 2, 2)
    p_val += n_inc

