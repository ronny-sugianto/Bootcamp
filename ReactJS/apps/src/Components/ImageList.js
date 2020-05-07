import React from 'react';

const ImageList = (props) => {
    const imgs = props.images.map((image) => {
        return <img src={image.url} alt='No Image' />
    });
    return (
        <div>
            {imgs}
        </div>
    )
}

export default ImageList;