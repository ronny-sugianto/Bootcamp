import React from 'react';

const getSeason = (mm) => {
    if (mm > 2 && mm < 9) {
        return 'Kemarau';
    } else {
        return 'Hujan';
    }
}
const SeasonConfig = {
    Kemarau: {
        color: 'bg-warning',
        icon: 'sun'
    },
    Hujan: {
        color: 'bg-primary',
        icon: 'umbrella'
    }
}
const SeasonDisplay = (props) => {
    const season = getSeason(new Date().getMonth());
    // const icon = season == 'Hujan' ? 'umberla' : 'sun';
    // const color = season == 'Hujan' ? 'bg-primary' : 'bg-warning';
    const { color, icon } = SeasonConfig[season];
    return (<div>
        <h2>Info Lokasi</h2>
        <div className={`p-3 mb2 ${color} text-white`}>
            <div className='text-title'>{icon}</div>
            <div className='text-info'>{season}</div>
        </div>
    </div>)
}

export default SeasonDisplay;