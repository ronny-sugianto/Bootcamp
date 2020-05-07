import React from 'react';

const Spinner = (props) => {
    return (
        <div>
            <div className='d-flex justify-content-center'>
                <div className='spinner-border' role='status' />


            </div>
            <strong className='d-flex mt-3 justify-content-center'>{props.message}</strong>
        </div>
    );
}

Spinner.defaultProps = {
    message: 'Loading...'
};

export default Spinner;