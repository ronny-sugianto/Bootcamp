import React from 'react';
import '../App.css';
import faker from 'faker';
import CardInfo from './Card_Info';
class Card extends React.Component {
    constructor() {
        super();
        this.state = {

            number: 0
        }
    }

    render() {
        return (
            <div className='card border-dark mb-3' style={{ maxWidth: '25rem' }}>
                <div className='card-body text-dark'>
                    {this.props.children}
                </div>
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
export default Card;