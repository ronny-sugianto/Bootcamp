import React from 'react';
import './Components/Header'
import './App.css';
import Header from './Components/Header';
import Card from './Components/Card';
import CardInfo from './Components/Card_Info';


class App extends React.Component {

  constructor() {
    super();
    this.state = {
      peoples:
        [{
          name: 'Ronny',
          age: 21

        }, {
          name: 'Sugianto',
          age: 20
        }],

    }
  }



  render() {
    const items = [];
    for (var i = 0; i < this.state.peoples.length; i++) {
      items.push(
        <Card>
          <CardInfo name='TES' />

        </Card>);
    }
    return (
      <div>
        <Header />
        <center style={{ padding: 30 }}>
          <button className='btn btn-primary' onClick={this.tambah} style={{ height: 50 }}>TAMBAH</button>

          <button className='btn btn-warning' onClick={this.kurang} style={{ height: 50 }}>KURANG</button>
        </center>
        <div className='container'>
          {items}<br />


        </div>
      </div>
    );
  }
  tambah = () => {
    this.state.peoples.push({ name: 'DUMMY', age: 20 });
    this.setState(this.state
    );
  }
  kurang = () => {
    this.state.peoples.pop();
    this.setState(this.state);
  }
}

export default App;
