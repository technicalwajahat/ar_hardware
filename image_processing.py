import cv2
import numpy as np
import base64


def read_image_from_base64(base64_string):
    # Decode the Base64 string to binary data
    binary_data = base64.b64decode(base64_string)

    # Convert binary data to NumPy array
    np_array = np.frombuffer(binary_data, dtype=np.uint8)

    # Decode the NumPy array to an image
    img = cv2.imdecode(np_array, cv2.IMREAD_COLOR)

    return cv2.cvtColor(img, cv2.COLOR_BGR2RGB)


def resize_and_pad(img, size, pad_color=0):
    h, w = img.shape[:2]
    sh, sw = size

    if h > sh or w > sw:
        interp = cv2.INTER_AREA
    else:
        interp = cv2.INTER_CUBIC

    aspect = w / h

    if aspect > 1:
        new_w = sw
        new_h = np.round(new_w / aspect).astype(int)
        pad_vert = (sh - new_h) / 2
        pad_top, pad_bot = np.floor(pad_vert).astype(int), np.ceil(pad_vert).astype(int)
        pad_left, pad_right = 0, 0
    elif aspect < 1:
        new_h = sh
        new_w = np.round(new_h * aspect).astype(int)
        pad_horz = (sw - new_w) / 2
        pad_left, pad_right = np.floor(pad_horz).astype(int), np.ceil(pad_horz).astype(int)
        pad_top, pad_bot = 0, 0
    else:
        new_h, new_w = sh, sw
        pad_left, pad_right, pad_top, pad_bot = 0, 0, 0, 0

    # set pad color
    if len(img.shape) == 3 and not isinstance(pad_color,
                                              (list, tuple, np.ndarray)):  # color image but only one color provided
        pad_color = [pad_color] * 3

    # scale and pad
    scaled_img = cv2.resize(img, (new_w, new_h), interpolation=interp)
    scaled_img = cv2.copyMakeBorder(scaled_img, pad_top, pad_bot, pad_left, pad_right, borderType=cv2.BORDER_CONSTANT,
                                    value=pad_color)

    return scaled_img


def get_outline_img(img):
    return cv2.Canny(img, 17, 250)  # todo: can be optimised later


def get_colored_image(img, new_color, pattern_image):
    hsv_image = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)
    h, s, v = cv2.split(hsv_image)
    new_hsv_image = hsv_image

    if new_color is not None:
        color = np.uint8([[new_color]])
        hsv_color = cv2.cvtColor(color, cv2.COLOR_RGB2HSV)
        h.fill(hsv_color[0][0][0])  # todo: optimise to handle black/white walls
        s.fill(hsv_color[0][0][1])
        new_hsv_image = cv2.merge([h, s, v])

    else:
        pattern = cv2.imread(pattern_image)
        hsv_pattern = cv2.cvtColor(pattern, cv2.COLOR_BGR2HSV)
        hp, sp, vp = cv2.split(hsv_pattern)
        # cv2.add(vp, v, vp)
        new_hsv_image = cv2.merge([hp, sp, v])

    new_rgb_image = cv2.cvtColor(new_hsv_image, cv2.COLOR_HSV2RGB)
    return new_rgb_image


def select_wall(outline_img, position):
    h, w = outline_img.shape[:2]
    wall = outline_img.copy()
    scaled_mask = resize_and_pad(outline_img, (h + 2, w + 2), 255)
    cv2.floodFill(wall, scaled_mask, position, 255)  # todo: can be optimised later
    cv2.subtract(wall, outline_img, wall)
    return wall


def merge_images(img, colored_image, wall):
    colored_image = cv2.bitwise_and(colored_image, colored_image, mask=wall)
    marked_img = cv2.bitwise_and(img, img, mask=cv2.bitwise_not(wall))
    final_img = cv2.bitwise_xor(colored_image, marked_img)
    return final_img


def save_image(img_name, img):
    img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
    cv2.imwrite(img_name, img)

def change_color(image_name, position, new_color, pattern_image):
    img = read_image_from_base64(image_name)
    colored_image = get_colored_image(img, new_color, pattern_image)
    outline_img = get_outline_img(img)
    selected_wall = select_wall(outline_img, position)
    final_img = merge_images(img, colored_image, selected_wall)
    return final_img


