import base64
from io import BytesIO

from PIL import Image
from flask import Flask, request, jsonify

from image_processing import change_color

app = Flask(__name__)


def convert_nparray_to_base64(img_array):
    # Convert the NumPy array to a Pillow Image
    img = Image.fromarray(img_array)

    # Convert the image to a binary format
    buffered = BytesIO()
    img.save(buffered, format="PNG")

    # Encode the binary data in Base64
    base64_encoded = base64.b64encode(buffered.getvalue()).decode('utf-8')

    return base64_encoded


@app.route('/getProcessedImage', methods=['POST'])
def process_image():
    if request.method == 'POST':
        try:
            data = request.get_json()

            img_data = data['img_data']
            color_picked = data['color_picked']

            # your coming color should be like this ........ [220, 180, 170]

            process_img = change_color(img_data, (300, 100), color_picked, None)
            process_img_base64 = convert_nparray_to_base64(process_img)
            return jsonify({'result': str(process_img_base64)})

        except Exception as e:
            print(e)
            return jsonify({'error': str(e)})


if __name__ == "__main__":
    port = 8001
    app.run(host='0.0.0.0', port=port, debug=True)
