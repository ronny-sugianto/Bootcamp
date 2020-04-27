import React from 'react';
import '../App.css';
import faker from 'faker';
class CardInfo extends React.Component {
    constructor() {
        super();
        this.state = {

            number: 0
        }
    }

    render() {
        return (
            <div>
                <img src={faker.image.avatar()} alt='avatar' className='rounded' />
                <h5 className='card-title'>{this.props.name}</h5>

                <p classname='card-text'><small className='text-muted'>On : 7 Apr 2010</small></p>

            </div>
        );
    }

    tambah = () => {
        this.setState(
            { number: this.state.number - 1 }
        );
    }
    kurang = () => {
        this.setState({
            number: this.state.number + 1
        });
    }
}
export default CardInfo;