import pyvision as pv
import time
import pyvision.face.CascadeDetector as cd

if __name__ == '__main__':
    
    detector = cd.CascadeDetector()
    
    cam = pv.Webcam()
    time.sleep(1)
    for frame in cam:
        rects = detector(frame)
        for rect in rects:
            frame.annotateRect(rect)
        frame.show(delay=30)