const mongoose = require('mongoose')
const detailSchema = new mongoose.Schema({

  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'  
  },
  image: {
    type: String,
    default: null,
  },
    
  tripName: {
    type: String,
    required: true,
    trim: true,
    unique:true,
    maxlength:[12, "Trip Name cannot be more than 12 characters"]
  },
      
  description: {
    type: String,
    required: true,
    trim: true,
  },
  startDate: {
    type: String,
    required: true,
    trim: true,
  },
  endDate: {
    type: String,
    required: true,
    trim: true,
  },
})

module.exports = mongoose.model("Details", detailSchema);