# TSGYE: Two-stage Grape Yield Estimation
Utilize YOLOv4 for grape cluster detection on WGISD dataset, and annotate 58 images of WGISD test set on Huawei ModelArts platform for evaluating grape counting methods.

### Dataset
WGISD (Wine Grape Instance Segmentation Dataset): https://github.com/thsant/wgisd.

we punctuate the grape berries in each image, and then write all coordinate information into xml files.


GrapeCounting
- raw_images # 58 images from WGISD test set
- detect_images # cluster detecting results based on YOLOv4
- count_label # folder for counting label

### YOLOv4
Darknet: https://github.com/AlexeyAB/darknet.

### YOLOv4 grape cluster detection
YOLOv4
- obj.data # the dataset config file for YOLOv4 training and evaluating
- yolov4-obj-1.cfg # the config file of YOLOv4 training network
- yolov4-obj-1_best.weights # load this network weights, you can detect cluster boxes on WGISD dataset accurately
(download link ：https://pan.baidu.com/s/14zRQHkQJbEZU3PVXWi85Uw 
提取码：nx9z)

After you follow the Darknet guideline to deploy YOLO network. you can predict grape clusters by following code.

### Predict clusters
```
./darknet detector test cfg/obj.data cfg/yolov4-obj-1.cfg weights/yolov4/yolov4-obj-1_best.weights
```
