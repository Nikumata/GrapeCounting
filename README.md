# GrapeCounting
Utilize YOLOv4 for grape cluster detection on WGISD dataset, and annotate 58 images of WGISD test set on Huawei ModelArts platform for evaluating grape counting methods

### Dataset
WGISD: https://github.com/thsant/wgisd

### GrapeCounting folder
- raw_images # 58 images from WGISD test set
- detect_images # cluster detecting results based on YOLOv4
- count_label # folder for counting label

### YOLOv4
Darknet: https://github.com/AlexeyAB/darknet

### YOLOv4 grape cluster detection
./YOLOv4/yolov4-obj-1.cfg # the config file of YOLOv4 training network

./YOLOv4/yolov4-obj-1_best.weights # load this network weights, you can detect cluster boxes on WGISD dataset accurately
(download link ：https://pan.baidu.com/s/14zRQHkQJbEZU3PVXWi85Uw 
提取码：nx9z)

After you follow the Darknet guideline to employ YOLO network.

### predict an grape image
```
./darknet detector test cfg/obj.data cfg/yolov4-obj-1.cfg weights/yolov4/yolov4-obj-1_last.weights
```
